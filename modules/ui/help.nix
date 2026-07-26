{
  flake.modules.nvf.ui-help = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      binds.whichKey = {
        enable = true;

        setupOpts = {
          preset = "helix";
          sort = ["group" "desc"];
        };

        register = {
          "<leader>d" = "+Debugger";
          "<leader>f" = "+Files";
          "<leader>s" = "+Search";
          "[" = "+Previous";
          "]" = "+Next";
          "g" = "+Goto";
          "z" = "+Fold";
        };
      };

      keymaps = [
        (mkKeymap "n" "<leader>?" "<CMD>lua require('which-key').show({ global = false })<CR>" {
          silent = true;
          desc = "Buffer Keymaps";
        })
      ];
    };
  };
}
