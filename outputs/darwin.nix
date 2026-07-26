{config, ...}: let
  inherit (config.flake.lib) mkOverlayedPkgs mkNvim integrationOptions;
in {
  flake.darwinModules.nvim-config = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.programs.nvim-config;
    overlayedPkgs = mkOverlayedPkgs pkgs.stdenv.hostPlatform.system;
    package =
      (mkNvim {
        moduleConfig = cfg;
        pkgs = overlayedPkgs;
      })
      .neovim;
  in {
    imports = [(integrationOptions {pkgs = overlayedPkgs;})];

    config = lib.mkIf cfg.enable {
      environment = {
        systemPackages = [package];

        variables = lib.mkIf cfg.neovim.defaultEditor {
          EDITOR = "${package}/bin/nvim";
          VISUAL = "${package}/bin/nvim";
        };
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
