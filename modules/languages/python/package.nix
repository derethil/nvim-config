{inputs, ...}: {
  flake-file.inputs.nvim-tcss = {
    url = "github:cachebag/nvim-tcss";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.nvim-tcss = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-tcss";
      pname = "nvim-tcss";
      src = inputs.nvim-tcss;
      meta = with lib; {
        description = "Textual CSS (TCSS) support for Neovim";
        homepage = "https://github.com/cachebag/nvim-tcss";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
