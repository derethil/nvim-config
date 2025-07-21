{
  vim.keymaps = [
    {
      key = "<Esc>";
      mode = ["n"];
      action = "<CMD>nohlsearch<CR>";
      silent = true;
      desc = "Clear search highlights";
    }
    {
      key = "<leader>qq";
      mode = ["n"];
      action = "<CMD>qa<CR>";
      desc = "Quit All";
    }
    {
      key = "<leader>q";
      mode = ["n"];
      action = "<CMD>q<CR>";
      desc = "Quit";
    }
    {
      key = "x";
      mode = ["n"];
      action = "\"_x";
      desc = "Delete without yanking";
    }
    {
      key = "p";
      mode = ["v"];
      action = "\"_dP";
      desc = "Paste without yanking";
    }
    {
      key = "<leader>j";
      mode = ["n"];
      action = "*``cgn";
      desc = "Replace word under cursor";
    }
    {
      key = "<C-c>";
      mode = ["n" "v" "i"];
      action = "<ESC>ggVGy";
      desc = "Yank all";
    }
  ];
}
