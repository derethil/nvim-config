{
  flake.modules.nvf.lib-snacks = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      keymaps = [
        (mkKeymap "n" "<leader>ghb" "<CMD>lua require('snacks.git').blame_line()<CR>" {desc = "Open Git Blame Context";})
        (mkKeymap "n" "<C-s>" "<CMD> lua require('snacks.words').jump(1, true)<CR>" {desc = "Jump to next word";})
      ];

      utility.snacks-nvim = {
        enable = true;

        setupOpts = {
          animate.enabled = false;
          bigfile.enabled = true;
          dashboard.enabled = false;
          explorer.enabled = false;
          git.enabled = true;

          indent = {
            animate.enabled = false;
            enabled = false;
          };

          input.enabled = false;
          notifier.enabled = false;
          picker.enabled = false;
          quickfile.enabled = false;
          rename.enabled = true;
          scope.enabled = true;
          scroll.enabled = false;
          statuscolumn.enabled = true;
          words.enabled = true;
        };
      };
    };
  };
}
