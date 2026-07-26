{
  flake.modules.nvf.ui-fastaction = {
    vim.ui.fastaction = {
      enable = true;

      setupOpts = {
        dismiss_keys = ["j" "k" "<C-c>" "q" "<Esc>"];
        popup.relative = "cursor";

        priority = {
          go = [
            {
              key = "f";
              order = 1;
              pattern = "add import";
            }
          ];

          typescript = [
            {
              key = "f";
              order = 1;
              pattern = "add import from";
            }
            {
              key = "d";
              order = 2;
              pattern = "update import from";
            }
          ];
        };

        register_ui_select = true;
      };
    };
  };
}
