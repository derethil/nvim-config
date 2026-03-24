{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "sort-nvim";
  pname = "sort-nvim";
  src = inputs.sort-nvim;
  meta = with lib; {
    description = "Sorting plugin for Neovim that supports line-wise and delimiter sorting";
    homepage = "https://github.com/sQVe/sort.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}