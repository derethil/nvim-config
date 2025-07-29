{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.binds.whichKey.register = {
    "<leader>b" = "+Buffers";
  };

  vim.tabline.nvimBufferline = {
    enable = true;
    setupOpts = {
      options = {
        numbers = "none";
        hover.enabled = false;
        show_close_icon = false;
        separator_style = ["|" "|"];
        indicator.style = "none";
        right_mouse_command = lib.generators.mkLuaInline "function(n) require('mini.bufremove').delete(n) end";
        close_command = lib.generators.mkLuaInline "function(n) require('mini.bufremove').delete(n) end";
        diagnostics = "nvim_lsp";
        always_show_bufferline = false;
      };
    };
    mappings = {
      closeCurrent = "<leader>bd";
      cycleNext = "<S-l>";
      cyclePrevious = "<S-h>";
      pick = "<leader>bp";
      moveNext = null;
      movePrevious = null;
      sortByDirectory = null;
      sortByExtension = null;
      sortById = null;
    };
  };

  vim.autocmds = [
    {
      event = ["BufAdd" "BufDelete"];
      desc = "Fix bufferline when adding/deleting buffers";
      callback = lib.generators.mkLuaInline ''
        function()
          vim.schedule(function()
            pcall(require, "bufferline")
          end)
        end
      '';
    }
  ];

  vim.keymaps = [
    (mkKeymap "n" "<leader>br" "<CMD>BufferLineCloseRight<CR>" {
      desc = "Delete Buffers to the Right";
      silent = true;
    })
    (mkKeymap "n" "<leader>bl" "<CMD>BufferLineCloseLeft<CR>" {
      desc = "Delete Buffers to the Left";
      silent = true;
    })
  ];

  vim.lazy.plugins.close-buffers-nvim = {
    package = pkgs.internal.close-buffers-nvim;
    setupModule = "close_buffers";
    setupOpts = {};
    lazy = true;
    keys = [
      (mkKeymap "n" "<leader>bo" "<CMD>lua require('close_buffers').delete({ type = 'hidden' })<CR>" {
        desc = "Close Buffers (hidden)";
        silent = true;
      })
      (mkKeymap "n" "<leader>bO" "<CMD>lua require('close_buffers').delete({ type = 'other' })<CR>" {
        desc = "Close Buffers";
        silent = true;
      })
    ];
  };
}
