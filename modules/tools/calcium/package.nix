{inputs, ...}: {
  flake-file.inputs.calcium = {
    url = "github:Necrom4/calcium.nvim";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.calcium-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "calcium-nvim";
      pname = "calcium-nvim";
      src = inputs.calcium;
      meta = with lib; {
        description = "A calculator plugin for Neovim";
        homepage = "https://github.com/Necrom4/calcium.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
