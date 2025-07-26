{
  vim.mini.icons = {
    enable = true;
    setupOpts = {
      # Set up icons for custom completion providers
      lsp = {
        copilot = {
          glyph = "";
          hl = "MiniIconsCyan";
        };
        yank = {
          glyph = "";
          hl = "MiniIconsYellow";
        };
      };
    };
  };

  vim.luaConfigRC.mini_icons_mock = ''
    require("mini.icons").mock_nvim_web_devicons()
  '';
}
