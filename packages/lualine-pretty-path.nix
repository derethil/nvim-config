{
  lib,
  vimUtils,
  inputs,
  vimPlugins,
}:
vimUtils.buildVimPlugin {
  name = "lualine-pretty-path";
  pname = "lualine-pretty-path";
  src = inputs.lualine-pretty-path;
  dependencies = [vimPlugins.lualine-nvim];
  meta = with lib; {
    description = "A LazyVim-style filename component for lualine.nvim";
    homepage = "https://github.com/bwpge/lualine-pretty-path";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
