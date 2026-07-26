{
  flake.modules.nvf.keymaps = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (lib.whichkey) mkEntry;
  in {
    vim = {
      keymaps = [
        (mkKeymap "n" "<Esc>" "<CMD>nohlsearch<CR>" {
          silent = true;
          desc = "Clear search highlights";
        })
        (mkKeymap "n" "<leader>qq" "<CMD>qa<CR>" {desc = "Quit All";})
        (mkKeymap "n" "<leader>q" "<CMD>q<CR>" {desc = "Quit";})
        (mkKeymap "n" "x" "\"_x" {desc = "Delete without yanking";})
        (mkKeymap "v" "p" "\"_dP" {desc = "Paste without yanking";})
        (mkKeymap "n" "<leader>j" "*``cgn" {desc = "Replace word";})
        (mkKeymap "n" "J" "<CMD>lua local p = vim.api.nvim_win_get_cursor(0); vim.cmd('normal! J'); vim.api.nvim_win_set_cursor(0, p)<CR>" {desc = "Join lines";})
        (mkKeymap ["n" "v" "i"] "<C-c>" "<ESC>ggVG" {desc = "Select all";})
        (mkKeymap ["v"] "<space>yb" ":'<,'>CopyCodeBlock<cr>" {desc = "Copy code block with filetype";})
      ];

      luaConfigRC.whichkey-keymaps = lib.nvim.dag.entryAnywhere (mkEntry {
        key = "<leader>j";
        color = "orange";
        icon = "";
        desc = "Replace word";
      });
    };
  };
}
