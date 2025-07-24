{
  vim.lazy.plugins = {
    plenary-nvim = {
      package = "plenary-nvim";
      priority = 100;
    };
    telescope = {
      package = "telescope";
      setupModule = "telescope";
      setupOpts = {
        defaults = {
          layout_strategy = "flex";
          sorting_strategy = "ascending";
          layout_config = {
            vertical = {
              prompt_position = "top";
              mirror = true;
            };
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
            };
            flex = {
              flip_columns = 150;
            };
          };
          mappings = {
            i = {"<esc>" = "close";};
            n = {"<esc>" = "close";};
          };
        };
      };
      keys = [
        {
          key = "<leader>p";
          mode = ["n" "x"];
          action = "function() require('yanky.telescope.yank_history').yank_history() end";
          lua = true;
          desc = "Open Yank History";
        }
      ];
    };
  };
}
