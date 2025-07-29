{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins = {
    "colorful-winsep.nvim" = {
      package = pkgs.vimPlugins.colorful-winsep-nvim;
      setupModule = "colorful-winsep";
      setupOpts = {};
      lazy = true;
      event = ["WinNew"];
    };
  };

  vim.keymaps = [
    # Window Navigation
    (mkKeymap "n" "<C-h>" "<C-w>h" {
      desc = "Go to Left Window";
      silent = true;
    })
    (mkKeymap "n" "<C-j>" "<C-w>j" {
      desc = "Go to Lower Window";
      silent = true;
    })
    (mkKeymap "n" "<C-k>" "<C-w>k" {
      desc = "Go to Upper Window";
      silent = true;
    })
    (mkKeymap "n" "<C-l>" "<C-w>l" {
      desc = "Go to Right Window";
      silent = true;
    })

    # Window Resizing
    (mkKeymap "n" "<C-Up>" "<CMD>resize +2<CR>" {
      desc = "Increase Window Height";
      silent = true;
    })
    (mkKeymap "n" "<C-Down>" "<CMD>resize -2<CR>" {
      desc = "Decrease Window Height";
      silent = true;
    })
    (mkKeymap "n" "<C-Left>" "<CMD>vertical resize -2<CR>" {
      desc = "Decrease Window Width";
      silent = true;
    })
    (mkKeymap "n" "<C-Right>" "<CMD>vertical resize +2<CR>" {
      desc = "Increase Window Width";
      silent = true;
    })

    # Window Splitting
    (mkKeymap "n" "<leader>-" "<C-w>s" {
      desc = "Split Window Below";
      silent = true;
    })
    (mkKeymap "n" "<leader>|" "<C-w>v" {
      desc = "Split Window Right";
      silent = true;
    })

    # Window Management
    (mkKeymap "n" "<leader>wd" "<C-w>c" {
      desc = "Delete Window";
      silent = true;
    })
  ];

  vim.binds.whichKey.register = {
    "<leader>w" = "+Windows";
  };
}
