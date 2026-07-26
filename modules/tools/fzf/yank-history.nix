{
  flake.modules.nvf.tools-fzf-yank-history = {
    vim.lazy.plugins.telescope = {
      package = "telescope";
      setupModule = "telescope";

      setupOpts.defaults = {
        layout_config = {
          flex.flip_columns = 150;

          horizontal = {
            preview_width = 0.55;
            prompt_position = "top";
          };

          vertical = {
            mirror = true;
            prompt_position = "top";
          };
        };

        layout_strategy = "flex";

        mappings = {
          i."<esc>" = "close";
          n."<esc>" = "close";
        };

        sorting_strategy = "ascending";
      };

      keys = [
        {
          key = "<leader>p";
          action = "function() require('yanky.telescope.yank_history').yank_history() end";
          lua = true;
          mode = ["n" "x"];
          desc = "Search Yank History";
        }
      ];
    };
  };
}
