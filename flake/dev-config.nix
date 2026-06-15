{lib, ...}: {
  options.flake.devModuleConfig = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    internal = true;
    description = ''
      Module configuration applied when building the development neovim
      package (`nix run .#dev`). Shape mirrors `programs.nvim-config.*`
      options exposed by the integration modules.
    '';
  };

  config.flake.devModuleConfig = {
    nixpkgs.config.allowUnfree = true;

    claude = {
      enable = true;
    };

    sonarlint = {
      enable = true;
      connectedMode = {
        enable = true;
        connections.sonarqube = [];
        projects = {};
      };
    };
  };
}
