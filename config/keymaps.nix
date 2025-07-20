{
  vim.keymaps = [
    {
      key = "<Esc>";
      mode = ["n"];
      action = "<CMD>nohlsearch<CR>";
      silent = true;
      desc = "Clear search highlights";
    }
  ];
}
