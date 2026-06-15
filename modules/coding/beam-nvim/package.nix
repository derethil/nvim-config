{inputs, ...}: {
  flake-file.inputs.beam-nvim = {
    url = "github:Piotr1215/beam.nvim";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.beam-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "beam-nvim";
      pname = "beam-nvim";
      src = inputs.beam-nvim;
      dependencies = [pkgs.vimPlugins.blink-cmp];
      meta = with lib; {
        description = "Beam nvim text operations on text objects anywhere in your file.";
        homepage = "https://github.com/Piotr1215/beam.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
