{inputs, ...}: {
  flake-file.inputs.lualine-pretty-path = {
    flake = false;
    url = "github:bwpge/lualine-pretty-path";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.lualine-pretty-path = pkgs.vimUtils.buildVimPlugin {
      dependencies = [pkgs.vimPlugins.lualine-nvim];
      name = "lualine-pretty-path";
      pname = "lualine-pretty-path";
      src = inputs.lualine-pretty-path;

      meta = with lib; {
        description = "A LazyVim-style filename component for lualine.nvim";
        homepage = "https://github.com/bwpge/lualine-pretty-path";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
