{
  config,
  lib,
  ...
}: let
  inherit (config.flake.lib) mkOverlayedPkgs mkNvim integrationOptions;
in {
  # flake-parts ships option declarations for nixosModules and darwinModules
  # but not homeManagerModules (it's a home-manager convention, not a core
  # flake output). Declare it so this module contributes a known output rather
  # than triggering "unknown flake output".
  options.flake.homeManagerModules = lib.mkOption {
    default = {};
    type = lib.types.lazyAttrsOf lib.types.unspecified;
  };

  config.flake.homeManagerModules.nvim-config = {
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
      home = {
        packages = [package];

        sessionVariables = lib.mkIf cfg.neovim.defaultEditor {
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
