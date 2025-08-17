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
      fzf_opts = {
        winopts = {
          height = 0.85;
          width = 0.8;
          backdrop = 60;
        };
      };
    };
    keys = [
      (mkKeymap "n" "<leader>aF" "<CMD>silent! ClaudeFzfFiles<CR>" {desc = "Claude: Find Files";})
      (mkKeymap "n" "<leader>ag" "<CMD>silent! ClaudeFzfGrep<CR>" {desc = "Claude: Grep Files";})
      (mkKeymap "n" "<leader>aB" "<CMD>silent! ClaudeFzfBuffers<CR>" {desc = "Claude: Find Buffers";})
      (mkKeymap "n" "<leader>aG" "<CMD>silent! ClaudeFzfGitFiles<CR>" {desc = "Claude: Find Git Files";})
    ];
  };
}
