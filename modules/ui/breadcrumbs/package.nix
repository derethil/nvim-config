{inputs, ...}: {
  flake-file.inputs.lualine-pretty-path = {
    url = "github:bwpge/lualine-pretty-path";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.lualine-pretty-path = pkgs.vimUtils.buildVimPlugin {
      name = "lualine-pretty-path";
      pname = "lualine-pretty-path";
      src = inputs.lualine-pretty-path;
      dependencies = [pkgs.vimPlugins.lualine-nvim];
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
