{
  vim.binds.whichKey = {
    enable = true;
    setupOpts = {
      preset = "helix";
    };
    register = {
      "<leader>s" = "+Search";
      "<leader>f" = "+Files";
      "<leader>u" = "+UI";
      "[" = "+Previous";
      "]" = "+Next";
      "g" = "+Goto";
      "z" = "+Fold";
    };
  };

  vim.keymaps = [
    {
      key = "<leader>?";
      mode = ["n"];
      action = "<CMD>lua require('which-key').show({ global = false })<CR>";
      silent = true;
      desc = "Buffer Keymaps";
    }
  ];
}
