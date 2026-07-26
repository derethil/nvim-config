{lib, ...}: {
  options.flake.devModuleConfig = lib.mkOption {
    default = {};

    description = ''
      Module configuration applied when building the development neovim
      package (`nix run .#dev`). Shape mirrors `programs.nvim-config.*`
      options exposed by the integration modules.
    '';

    internal = true;
    type = lib.types.attrs;
  };

  config.flake.devModuleConfig = {
    claude.enable = true;
    nixpkgs.config.allowUnfree = true;

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
