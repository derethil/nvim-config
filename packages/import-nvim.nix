{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "import.nvim";
  pname = "import-nvim";
  src = inputs.import-nvim;
  nvimSkipModule = ["import.pickers.telescope"];
  meta = with lib; {
    description = "A safe require override with niceties";
    homepage = "https://github.com/piersolenski/import.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}