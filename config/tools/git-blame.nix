{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins = {
    "git-blame.nvim" = {
      package = pkgs.vimPlugins.git-blame-nvim;
      event = [lib.events.VeryLazy];
      setupModule = "gitblame";
      setupOpts = {
        display_virtual_text = false;
        message_template = "<author> • <date>";
        date_format = "%r";
        message_when_not_committed = "Not Committed";
        delay = 0;
      };
      keys = [
        (mkKeymap "n" "<leader>gC" "<cmd>GitBlameOpenCommitURL<CR>" {desc = "Open Git Commit URL";})
      ];
    };
  };
}
