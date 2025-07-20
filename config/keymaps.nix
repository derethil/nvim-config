{
  vim.binds.whichKey = {
    enable = true;
    setupOpts = {
      preset = "helix";
    };
    register = {
      "[" = "+prev";
      "]" = "+next";
      "g" = "+goto";
      "gs" = "+surround";
      "z" = "+fold";
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
