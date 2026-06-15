{inputs, ...}: {
  flake-file.inputs.gopher-nvim = {
    url = "github:olexsmir/gopher.nvim";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.gopher-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "gopher.nvim";
      pname = "gopher-nvim";
      src = inputs.gopher-nvim;
      meta = with lib; {
        description = "Neovim plugin for make golang development easiest";
        homepage = "https://github.com/olexsmir/gopher.nvim";
        license = licenses.asl20;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
