{
  flake.modules.nvf.ui-buffers = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      lazy.plugins = {
        close-buffers-nvim = {
          package = pkgs.internal.close-buffers-nvim;
          lazy = true;
          setupModule = "close_buffers";
          setupOpts = {};

          keys = [
            (mkKeymap "n" "<leader>bo" "<CMD>lua require('close_buffers').delete({ type = 'hidden' })<CR>" {
              silent = true;
              desc = "Close Buffers (hidden)";
            })
            (mkKeymap "n" "<leader>bO" "<CMD>lua require('close_buffers').delete({ type = 'other' })<CR>" {
              silent = true;
              desc = "Close Buffers";
            })
          ];
        };

        "scope.nvim" = {
          package = pkgs.vimPlugins.scope-nvim;
          setupModule = "scope";
          setupOpts = {};
          event = [lib.events.VeryLazy];
        };
      };

      autocmds = [
        {
          event = ["BufAdd" "BufDelete"];

          callback = lib.generators.mkLuaInline ''
            function()
              vim.schedule(function()
                pcall(require, "bufferline")
              end)
            end
          '';

          desc = "Fix bufferline when adding/deleting buffers";
        }
      ];

      binds.whichKey.register."<leader>b" = "+Buffers";

      keymaps = [
        (mkKeymap "n" "<leader>br" "<CMD>BufferLineCloseRight<CR>" {
          silent = true;
          desc = "Delete Buffers to the Right";
        })
        (mkKeymap "n" "<leader>bl" "<CMD>BufferLineCloseLeft<CR>" {
          silent = true;
          desc = "Delete Buffers to the Left";
        })
      ];

      tabline.nvimBufferline = {
        enable = true;

        setupOpts.options = {
          always_show_bufferline = false;
          close_command = lib.generators.mkLuaInline "function(n) require('mini.bufremove').delete(n) end";
          diagnostics = "nvim_lsp";
          hover.enabled = false;
          indicator.style = "none";
          numbers = "none";
          right_mouse_command = lib.generators.mkLuaInline "function(n) require('mini.bufremove').delete(n) end";
          separator_style = ["|" "|"];
          show_close_icon = false;
        };

        mappings = {
          closeCurrent = "<leader>bd";
          cycleNext = "<S-l>";
          cyclePrevious = "<S-h>";
          moveNext = null;
          movePrevious = null;
          pick = "<leader>bp";
          sortByDirectory = null;
          sortByExtension = null;
          sortById = null;
        };
      };
    };
  };
}
