{inputs, ...}: {
  flake-file.inputs.import-nvim = {
    flake = false;
    url = "github:piersolenski/import.nvim";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.import-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "import.nvim";
      nvimSkipModule = ["import.pickers.telescope"];
      pname = "import-nvim";
      src = inputs.import-nvim;

      meta = with lib; {
        description = "A safe require override with niceties";
        homepage = "https://github.com/piersolenski/import.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
