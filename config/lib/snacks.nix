{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.utility.snacks-nvim = {
    enable = true;
    setupOpts = {
      animate = {enabled = false;};
      rename = {enabled = true;};
      bigfile = {enabled = true;};
      git = {enabled = true;};
      dashboard = {enabled = false;};
      explorer = {enabled = false;};
      indent = {enabled = false;};
      input = {enabled = false;};
      picker = {enabled = false;};
      notifier = {enabled = false;};
      quickfile = {enabled = false;};
      scope = {enabled = false;};
      scroll = {enabled = false;};
      statuscolumn = {enabled = true;};
      words = {enabled = false;};
    };
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>ghb" "<CMD>lua require('snacks.git').blame_line()<CR>" {desc = "Open Git Blame Context";})
  ];
}
