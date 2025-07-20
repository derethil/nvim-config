{pkgs, ...}:
with pkgs.vimPlugins; {
  vim.lazy.plugins = {
    "colorful-winsep.nvim" = {
      package = colorful-winsep-nvim;
      setupModule = "colorful-winsep";
      setupOpts = {};
      lazy = true;
      event = ["WinNew"];
    };
  };

  vim.keymaps = [
    # Window Navigation
    {
      key = "<C-h>";
      mode = ["n"];
      action = "<C-w>h";
      silent = true;
      desc = "Go to Left Window";
    }
    {
      key = "<C-j>";
      mode = ["n"];
      action = "<C-w>j";
      silent = true;
      desc = "Go to Lower Window";
    }
    {
      key = "<C-k>";
      mode = ["n"];
      action = "<C-w>k";
      silent = true;
      desc = "Go to Upper Window";
    }
    {
      key = "<C-l>";
      mode = ["n"];
      action = "<C-w>l";
      silent = true;
      desc = "Go to Right Window";
    }

    # Window Resizing
    {
      key = "<C-Up>";
      mode = ["n"];
      action = "<CMD>resize +2<CR>";
      silent = true;
      desc = "Increase Window Height";
    }
    {
      key = "<C-Down>";
      mode = ["n"];
      action = "<CMD>resize -2<CR>";
      silent = true;
      desc = "Decrease Window Height";
    }
    {
      key = "<C-Left>";
      mode = ["n"];
      action = "<CMD>vertical resize -2<CR>";
      silent = true;
      desc = "Decrease Window Width";
    }
    {
      key = "<C-Right>";
      mode = ["n"];
      action = "<CMD>vertical resize +2<CR>";
      silent = true;
      desc = "Increase Window Width";
    }

    # Window Splitting
    {
      key = "<leader>-";
      mode = ["n"];
      action = "<C-w>s";
      silent = true;
      desc = "Split Window Below";
    }
    {
      key = "<leader>|";
      mode = ["n"];
      action = "<C-w>v";
      silent = true;
      desc = "Split Window Right";
    }

    # Window Management
    {
      key = "<leader>wd";
      mode = ["n"];
      action = "<C-w>c";
      silent = true;
      desc = "Delete Window";
    }
  ];

  vim.binds.whichKey.register = {
    "<leader>w" = "+windows";
  };
}
