{
  flake.modules.nvf.ui-highlight-colors = {
    vim.ui.nvim-highlight-colors = {
      enable = true;

      setupOpts = {
        enable_named_colors = true;
        enable_tailwind = true;
        render = "virtual";
        virtual_symbol = "";
      };
    };
  };
}
