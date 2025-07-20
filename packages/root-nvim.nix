{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "root.nvim";
  pname = "root-nvim";
  src = inputs.root-nvim;
  meta = with lib; {
    description = "Find the root of your project directory in Neovim.";
    homepage = "https://github.com/flashios09/root.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
