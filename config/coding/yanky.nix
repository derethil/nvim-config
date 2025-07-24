{
  vim.utility.yanky-nvim = {
    enable = true;
    setupOpts = {
      ring.storage = "sqlite";
      highlight = {
        timer = 150;
      };
    };
  };

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

  vim.keymaps = [
    {
      key = "y";
      mode = ["n" "x"];
      action = "<Plug>(YankyYank)";
      desc = "Yank Text";
    }
    {
      key = "p";
      mode = ["n" "x"];
      action = "<Plug>(YankyPutAfter)";
      desc = "Put Text After Cursor";
    }
    {
      key = "P";
      mode = ["n" "x"];
      action = "<Plug>(YankyPutBefore)";
      desc = "Put Text Before Cursor";
    }
    {
      key = "gp";
      mode = ["n" "x"];
      action = "<Plug>(YankyGPutAfter)";
      desc = "Put Text After Selection";
    }
    {
      key = "gP";
      mode = ["n" "x"];
      action = "<Plug>(YankyGPutBefore)";
      desc = "Put Text Before Selection";
    }
    {
      key = "[y";
      mode = ["n"];
      action = "<Plug>(YankyCycleForward)";
      desc = "Cycle Forward Through Yank History";
    }
    {
      key = "]y";
      mode = ["n"];
      action = "<Plug>(YankyCycleBackward)";
      desc = "Cycle Backward Through Yank History";
    }
    {
      key = "]p";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentAfterLinewise)";
      desc = "Put Indented After Cursor (Linewise)";
    }
    {
      key = "[p";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentBeforeLinewise)";
      desc = "Put Indented Before Cursor (Linewise)";
    }
    {
      key = "]P";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentAfterLinewise)";
      desc = "Put Indented After Cursor (Linewise)";
    }
    {
      key = "[P";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentBeforeLinewise)";
      desc = "Put Indented Before Cursor (Linewise)";
    }
    {
      key = ">p";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentAfterShiftRight)";
      desc = "Put and Indent Right";
    }
    {
      key = "<p";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentAfterShiftLeft)";
      desc = "Put and Indent Left";
    }
    {
      key = ">P";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentBeforeShiftRight)";
      desc = "Put Before and Indent Right";
    }
    {
      key = "<P";
      mode = ["n"];
      action = "<Plug>(YankyPutIndentBeforeShiftLeft)";
      desc = "Put Before and Indent Left";
    }
    {
      key = "=p";
      mode = ["n"];
      action = "<Plug>(YankyPutAfterFilter)";
      desc = "Put After Applying a Filter";
    }
    {
      key = "=P";
      mode = ["n"];
      action = "<Plug>(YankyPutBeforeFilter)";
      desc = "Put Before Applying a Filter";
    }
  ];
}
