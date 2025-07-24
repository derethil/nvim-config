{
  vim.languages.go = {
    dap.enable = false;
    enable = false;
    lsp.enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
    };
  };

  vim.mini.icons.setupOpts = {
    file = {
      ".go-version" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
    };
    filetype = {
      gotmpl = {
        glyph = "󰟓";
        hl = "MiniIconsGrey";
      };
    };
  };
}
