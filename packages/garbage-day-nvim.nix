{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "garbage-day.nvim";
  pname = "garbage-day-nvim";
  src = inputs.garbage-day-nvim;
  meta = with lib; {
    description = "Garbage collector that stops inactive LSP clients to free RAM";
    homepage = "https://github.com/Zeioth/garbage-day.nvim";
    license = licenses.gpl3;
    maintainers = [];
    platforms = platforms.all;
  };
}
