{
  vim.ui.fastaction = {
    enable = true;
    setupOpts = {
      dismiss_keys = ["j" "k" "<C-c>" "q" "<Esc>"];
      register_ui_select = true;
      popup = {
        relative = "cursor";
      };
      priority = {
        typescript = [
          {
            pattern = "add import from";
            key = "f";
            order = 1;
          }
          {
            pattern = "update import from";
            key = "d";
            order = 2;
          }
        ];
        go = [
          {
            pattern = "add import";
            key = "f";
            order = 1;
          }
        ];
      };
    };
  };
}
