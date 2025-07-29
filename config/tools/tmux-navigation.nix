{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.vim-tmux-navigator = {
    package = pkgs.vimPlugins.vim-tmux-navigator;
    event = ["VimEnter"];
    keys = [
      (mkKeymap "n" "<C-h>" "<CMD><C-U>TmuxNavigateLeft<CR>" {desc = "Focus Left";})
      (mkKeymap "n" "<C-l>" "<CMD><C-U>TmuxNavigateRight<CR>" {desc = "Focus Right";})
      (mkKeymap "n" "<C-j>" "<CMD><C-U>TmuxNavigateDown<CR>" {desc = "Focus Down";})
      (mkKeymap "n" "<C-k>" "<CMD><C-U>TmuxNavigateUp<CR>" {desc = "Focus Up";})
    ];
  };
}
