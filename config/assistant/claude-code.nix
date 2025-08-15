{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.binds.whichKey.register = {"<leader>a" = "+AI";};

  vim.lazy.plugins.claudecode-nvim = {
    package = pkgs.internal.claudecode-nvim;
    setupModule = "claudecode";
    setupOpts = {};
    keys = [
      # Interaction / Focus
      (mkKeymap "n" "<leader>aa" "<CMD>ClaudeCode<CR>" {desc = "Toggle Claude";})
      (mkKeymap "n" "<leader>ac" "<CMD>ClaudeCode --continue<CR>" {desc = "Continue Claude";})
      (mkKeymap "n" "<leader>ar" "<CMD>ClaudeCode --resume<CR>" {desc = "Resume Old Claude";})
      (mkKeymap "n" "<leader>af" "<CMD>ClaudeCodeFocus<CR>" {desc = "Focus Claude";})
      # Select Model
      (mkKeymap "n" "<leader>am" "<CMD>ClaudeCodeSelectModel<CR>" {desc = "Select Claude Model";})
      # Sending Context
      {
        mode = "x";
        key = "<leader>af";
        desc = "Focus and Send Selected to Claude";
        lua = true;
        action = ''
          function()
            vim.cmd('ClaudeCodeSend')
            vim.defer_fn(function()
               vim.cmd('ClaudeCodeFocus')
            end, 0)
          end
        '';
      }
      (mkKeymap "x" "<leader>as" "<CMD>ClaudeCodeSend<CR>" {desc = "Send Selection to Claude";})
      (mkKeymap "n" "<leader>ab" "<CMD>ClaudeCodeAdd %<CR>" {desc = "Send Current Buffer to Claude";})
      (mkKeymap "n" "<leader>as" "<CMD>ClaudeCodeTreeAdd<CR>" {
        desc = "Send Buffer to Claude";
        ft = ["minifiles"];
      })
      # Diff Management
      (mkKeymap "n" "<C-n>" "<CMD>ClaudeCodeDiffDeny<CR>" {desc = "Deny Claude Diff";})
      (mkKeymap "n" "<C-y>" "<CMD>ClaudeCodeDiffAccept<CR>" {desc = "Accept Claude Diff";})
    ];
  };

  vim.autocmds = [
    {
      event = ["TermOpen"];
      pattern = ["*"];
      desc = "Fix Navigation in Claude Terminal Buffers";
      callback =
        lib.generators.mkLuaInline
        /*
        lua
        */
        ''
          function()
            local buffer = vim.api.nvim_get_current_buf()
            local name = vim.api.nvim_buf_get_name(buffer)

            if name:match('claude') then
              local function tnoremap(lhs, rhs, opts)
                opts = opts or {}
                opts.buffer = buffer
                vim.keymap.set('t', lhs, rhs, opts)
              end

              -- Map Ctrl+h/j/k/l to navigate between tmux panes
              tnoremap('<C-h>', '<CMD>TmuxNavigateLeft<CR>')
              tnoremap('<C-j>', '<CMD>TmuxNavigateDown<CR>')
              tnoremap('<C-k>', '<CMD>TmuxNavigateUp<CR>')
              tnoremap('<C-l>', '<CMD>TmuxNavigateRight<CR>')
            end
          end
        '';
    }
  ];
}
