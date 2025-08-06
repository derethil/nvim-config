{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "kulala.nvim";
  pname = "kulala-nvim";
  src = inputs.kulala-nvim;
  nvimSkipModule = [ "cli.kulala_cli" ];
  meta = with lib; {
    description = "A HTTP client for Neovim, powered by Lua and cURL";
    homepage = "github:mistweaverco/kulala.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
