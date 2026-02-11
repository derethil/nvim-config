{
  vim.ui.fastaction = {
    enable = true;
    setupOpts = {
      dismiss_keys = ["j" "k" "<C-c>" "q" "<Esc>"];
      register_ui_select = true;
      popup = {
        relative = "cursor";
        # y_offset = 1;
      };
    };
  };
}
