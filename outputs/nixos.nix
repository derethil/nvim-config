{
  config,
  lib,
  ...
}: let
  inherit (config.flake.lib) mkOverlayedPkgs mkNvim integrationOptions;
in {
  flake.nixosModules.nvim-config = {
    config,
    pkgs,
    lib,
    ...
  }: let
    cfg = config.programs.nvim-config;
    overlayedPkgs = mkOverlayedPkgs pkgs.stdenv.hostPlatform.system;
    package =
      (mkNvim {
        pkgs = overlayedPkgs;
        moduleConfig = cfg;
      })
      .neovim;
  in {
    imports = [(integrationOptions {pkgs = overlayedPkgs;})];

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [package];
      environment.variables = lib.mkIf cfg.neovim.defaultEditor {
        EDITOR = "${package}/bin/nvim";
        VISUAL = "${package}/bin/nvim";
      };

      assertions = [
        {
          assertion = !(cfg.neovim.nightly && cfg.neovim.package != null);
          message = "Cannot enable both neovim.nightly and set a custom neovim.package. Choose one or the other.";
        }
      ];
    };
  };
}
