{
  flake-file.inputs.gitlab-nvim = {
    flake = false;
    url = "github:harrisoncramer/gitlab.nvim";
  };

  flake.modules.nvf.gitlab-nvim = {
    lib,
    pkgs,
    module ? {},
    ...
  }: let
    cfg = module.config.gitlab or {};
  in {
    vim = {
      lazy.plugins.gitlab-nvim = {
        package = pkgs.internal.gitlab-nvim;
        lazy = true;
        setupModule = "gitlab";

        setupOpts = lib.optionalAttrs (cfg.configDirPath or null != null) {
          config_path = lib.generators.mkLuaInline ''vim.fn.expand("${cfg.configDirPath}")'';
        };

        event = ["BufEnter"];
      };

      binds.whichKey.register."gl" = "+GitLab";
      extraPackages = [pkgs.go pkgs.gcc];
    };
  };
}
