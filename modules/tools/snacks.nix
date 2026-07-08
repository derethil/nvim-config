{...}: {
  flake.modules.nvf.lib-snacks = {lib, ...}: let
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
        indent = {
          enabled = false;
          animate.enabled = false;
        };
        input = {enabled = false;};
        picker = {enabled = false;};
        notifier = {enabled = false;};
        quickfile = {enabled = false;};
        scope = {enabled = true;};
        scroll = {enabled = false;};
        statuscolumn = {enabled = true;};
        words = {enabled = true;};
      };
    };

    vim.keymaps = [
      (mkKeymap "n" "<leader>ghb" "<CMD>lua require('snacks.git').blame_line()<CR>" {desc = "Open Git Blame Context";})
      (mkKeymap "n" "<C-s>" "<CMD> lua require('snacks.words').jump(1, true)<CR>" {desc = "Jump to next word";})
    ];
  };
}
