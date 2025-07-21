{pkgs, ...}: {
  vim.lazy.plugins.vim-tmux-navigator = {
    package = pkgs.vimPlugins.vim-tmux-navigator;
    event = ["VimEnter"];
    keys = [
      {
        key = "<C-h>";
        mode = ["n"];
        action = "<CMD><C-U>TmuxNavigateLeft<CR>";
        desc = "Focus Left";
      }
      {
        key = "<C-l>";
        mode = ["n"];
        action = "<CMD><C-U>TmuxNavigateRight<CR>";
        desc = "Focus Right";
      }
      {
        key = "<C-j>";
        mode = ["n"];
        action = "<CMD><C-U>TmuxNavigateDown<CR>";
        desc = "Focus Down";
      }
      {
        key = "<C-k>";
        mode = ["n"];
        action = "<CMD><C-U>TmuxNavigateUp<CR>";
        desc = "Focus Up";
      }
    ];
  };
}
