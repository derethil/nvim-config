{
  vim.mini.icons.enable = true;
  vim.luaConfigRC.mini_icons_mock = ''
    require("mini.icons").mock_nvim_web_devicons();
  '';
}
