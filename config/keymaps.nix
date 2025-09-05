{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.keymaps = [
    (mkKeymap "n" "<Esc>" "<CMD>nohlsearch<CR>" {
      desc = "Clear search highlights";
      silent = true;
    })
    (mkKeymap "n" "<leader>qq" "<CMD>qa<CR>" {desc = "Quit All";})
    (mkKeymap "n" "<leader>q" "<CMD>q<CR>" {desc = "Quit";})
    (mkKeymap "n" "x" "\"_x" {desc = "Delete without yanking";})
    (mkKeymap "v" "p" "\"_dP" {desc = "Paste without yanking";})
    (mkKeymap "n" "<leader>j" "*``cgn" {desc = "Replace word under cursor";})
    (mkKeymap ["n" "v" "i"] "<C-c>" "<ESC>ggVGy" {desc = "Yank all";})
    (mkKeymap ["v"] "<space>yb" ":'<,'>CopyCodeBlock<cr>" {desc = "Copy code block with filetype";})
  ];
}
