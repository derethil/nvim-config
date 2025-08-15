{
  lib,
  vimUtils,
  inputs,
  vimPlugins,
}:
vimUtils.buildVimPlugin {
  name = "claudecode-nvim";
  pname = "claudecode-nvim";
  src = inputs.claudecode-nvim;
  dependencies = [vimPlugins.snacks-nvim];
  meta = with lib; {
    description = "Neovim integration for Claude Code.";
    homepage = "https://github.com/coder/claudecode.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
