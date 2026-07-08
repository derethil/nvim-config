{...}: {
  flake.modules.nvf.ui-help = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.binds.whichKey = {
      enable = true;
      setupOpts = {
        preset = "helix";
        sort = ["group" "desc"];
      };

      register = {
        "<leader>s" = "+Search";
        "<leader>f" = "+Files";
        "<leader>d" = "+Debugger";
        "[" = "+Previous";
        "]" = "+Next";
        "g" = "+Goto";
        "z" = "+Fold";
      };
    };

    vim.keymaps = [
      (mkKeymap "n" "<leader>?" "<CMD>lua require('which-key').show({ global = false })<CR>" {
        desc = "Buffer Keymaps";
        silent = true;
      })
    ];
  };
}
