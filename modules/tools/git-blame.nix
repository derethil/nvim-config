{
  flake.modules.nvf.tools-git-blame = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.lazy.plugins."git-blame.nvim" = {
      package = pkgs.vimPlugins.git-blame-nvim;
      setupModule = "gitblame";

      setupOpts = {
        date_format = "%r";
        delay = 0;
        display_virtual_text = false;
        message_template = "<author> • <date>";
        message_when_not_committed = "Not Committed";
      };

      event = [lib.events.VeryLazy];

      keys = [
        (mkKeymap "n" "<leader>gC" "<cmd>GitBlameOpenCommitURL<CR>" {desc = "Open Git Commit URL";})
      ];
    };
  };
}
