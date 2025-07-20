{
  vim.statusline.lualine = {
    enable = true;
    activeSection = {
      a = [
        ''
          {
            "mode",
            icons_enabled = true,
          },
          {
            " ",
            draw_empty = true,
          }
        ''
      ];
      b = [];
      c = [
        ''
          {
            "filetype",
            colored = true,
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
            icon = { align = 'left' }
          }
        ''
        ''
          {
            "filename",
            symbols = {modified = ' ', readonly = ' '},
            separator = { right = "|" }
          }
        ''
        ''
          {
            "diff",
            colored = true,
            diff_color = {
              added    = 'DiffAdded',
              modified = 'DiffChanged',
              removed  = 'DiffRemoved',
            },
            symbols = {added = '+', modified = '~', removed = '-'}
          }
        ''
      ];
    };
  };
}
