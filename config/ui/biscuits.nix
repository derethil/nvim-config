{
  # TODO: Re-enable once https://github.com/code-biscuits/nvim-biscuits/pull/61 is merged
  # nvim-treesitter.ts_utils has been deprecated and causes startup crashes
  vim.utility.nvim-biscuits = {
    enable = false;
    setupOpts = {
      cursor_line_only = true;
    };
  };
}
