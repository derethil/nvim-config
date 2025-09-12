{
  pkgs,
  lib,
  module ? {},
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.nvim.binds) mkKeymap;
  cfg = module.config.claude or {};
in {
  config = mkIf (cfg.enable or false) {
    vim.binds.whichKey.register = {"<leader>a" = "+AI";};

    vim.extraPackages = [
      cfg.package or pkgs.claude-code
    ];

    vim.lazy.plugins.claudecode-nvim = {
      package = pkgs.internal.claudecode-nvim;
      setupModule = "claudecode";
      setupOpts = {};
      keys = [
        # Interaction / Focus
        (mkKeymap "n" "<leader>aa" "<CMD>ClaudeCode<CR>" {desc = "Claude: Toggle";})
        (mkKeymap "n" "<leader>ac" "<CMD>ClaudeCode --continue<CR>" {desc = "Claude: Continue";})
        (mkKeymap "n" "<leader>ar" "<CMD>ClaudeCode --resume<CR>" {desc = "Claude: Resume";})
        (mkKeymap "n" "<leader>af" "<CMD>ClaudeCodeFocus<CR>" {desc = "Claude: Focus";})
        # Select Model
        (mkKeymap "n" "<leader>am" "<CMD>ClaudeCodeSelectModel<CR>" {desc = "Claude: Select Model";})
        # Sending Context
        {
          mode = "x";
          key = "<leader>aa";
          desc = "Claude: Send Selection";
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
        {
          mode = "x";
          key = "<leader>af";
          desc = "Claude: Send Selection";
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
        (mkKeymap "x" "<leader>as" "<CMD>ClaudeCodeSend<CR>" {desc = "Claude: Send Selection";})
        (mkKeymap "n" "<leader>ab" "<CMD>ClaudeCodeAdd %<CR>" {desc = "Claude: Send Current Buffer";})
        (mkKeymap "n" "<leader>as" "<CMD>ClaudeCodeTreeAdd<CR>" {
          desc = "Claude: Send Selected Buffer";
          ft = ["minifiles"];
        })
        # Diff Management
        (mkKeymap "n" "<C-n>" "<CMD>ClaudeCodeDiffDeny<CR>" {desc = "Claude: Deny Diff";})
        (mkKeymap "n" "<C-y>" "<CMD>ClaudeCodeDiffAccept<CR>" {desc = "Claude: Accept Diff";})
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

              -- Only apply to actual claude terminal buffers, not fzf popups
              if name:match('claude') and not name:match('fzf') then
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
                tnoremap('<leader>aa', '<CMD>ClaudeCode<CR>', {desc = "Claude: Toggle"})
              end
            end
          '';
      }
    ];
  };
}
