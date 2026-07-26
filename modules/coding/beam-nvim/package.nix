{inputs, ...}: {
  flake-file.inputs.beam-nvim = {
    flake = false;
    url = "github:Piotr1215/beam.nvim";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.beam-nvim = pkgs.vimUtils.buildVimPlugin {
      dependencies = [pkgs.vimPlugins.blink-cmp];
      name = "beam-nvim";
      pname = "beam-nvim";
      src = inputs.beam-nvim;

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
