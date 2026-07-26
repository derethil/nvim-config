{
  flake.modules.nvf.ui-windows = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      lazy.plugins."colorful-winsep.nvim" = {
        package = pkgs.vimPlugins.colorful-winsep-nvim;
        lazy = true;
        setupModule = "colorful-winsep";
        setupOpts.animate.enabled = false;
        event = ["WinNew"];
      };

      binds.whichKey.register."<leader>w" = "+Windows";

      keymaps = [
        # Window Navigation
        (mkKeymap "n" "<C-h>" "<C-w>h" {
          silent = true;
          desc = "Go to Left Window";
        })
        (mkKeymap "n" "<C-j>" "<C-w>j" {
          silent = true;
          desc = "Go to Lower Window";
        })
        (mkKeymap "n" "<C-k>" "<C-w>k" {
          silent = true;
          desc = "Go to Upper Window";
        })
        (mkKeymap "n" "<C-l>" "<C-w>l" {
          silent = true;
          desc = "Go to Right Window";
        })

        # Window Resizing
        (mkKeymap "n" "<C-Up>" "<CMD>resize +8<CR>" {
          silent = true;
          desc = "Increase Window Height";
        })
        (mkKeymap "n" "<C-Down>" "<CMD>resize -8<CR>" {
          silent = true;
          desc = "Decrease Window Height";
        })
        (mkKeymap "n" "<C-Left>" "<CMD>vertical resize -8<CR>" {
          silent = true;
          desc = "Decrease Window Width";
        })
        (mkKeymap "n" "<C-Right>" "<CMD>vertical resize +8<CR>" {
          silent = true;
          desc = "Increase Window Width";
        })

        # Window Splitting
        (mkKeymap "n" "<leader>-" "<C-w>s" {
          silent = true;
          desc = "Split Window Below";
        })
        (mkKeymap "n" "<leader>|" "<C-w>v" {
          silent = true;
          desc = "Split Window Right";
        })

        # Window Management
        (mkKeymap "n" "<leader>wd" "<C-w>c" {
          silent = true;
          desc = "Delete Window";
        })
      ];
    };
  };
}
