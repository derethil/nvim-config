{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.claude-fzf-nvim = {
    setupModule = "claude-fzf";
    package = pkgs.internal.claude-fzf-nvim;
    setupOpts = {
      auto_context = true;
      batch_size = 10;
    };
    keys = [
      (mkKeymap "n" "<leader>aF" "<CMD>ClaudeFzfFiles<CR>" {desc = "Claude: Find Files";})
      (mkKeymap "n" "<leader>ag" "<CMD>ClaudeFzfGrep<CR>" {desc = "Claude: Grep Files";})
    ];
  };
}
