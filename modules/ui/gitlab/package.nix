{inputs, ...}: {
  flake-file.inputs.gitlab-nvim = {
    flake = false;
    url = "github:harrisoncramer/gitlab.nvim";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.gitlab-nvim = pkgs.vimUtils.buildVimPlugin {
      dependencies = [
        pkgs.vimPlugins.nui-nvim
      ];

      nativeBuildInputs = [
        pkgs.internal.diffview-plus-nvim
      ];

      name = "gitlab.nvim";
      nvimSkipModules = ["gitlab.colors"];
      pname = "gitlab-nvim";
      src = inputs.gitlab-nvim;

      meta = with lib; {
        description = "Manage Gitlab resources in Neovim";
        homepage = "https://github.com/harrisoncramer/gitlab.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
