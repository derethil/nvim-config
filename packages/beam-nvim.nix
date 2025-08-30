{
  lib,
  vimUtils,
  inputs,
  vimPlugins,
}:
vimUtils.buildVimPlugin {
  name = "beam-nvim";
  pname = "beam-nvim";
  src = inputs.beam-nvim;
  dependencies = [vimPlugins.blink-cmp];
  meta = with lib; {
    description = "Beam nvim text operations on text objects anywhere in your file.";
    homepage = "https://github.com/Piotr1215/beam.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
