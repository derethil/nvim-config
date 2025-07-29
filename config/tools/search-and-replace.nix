{pkgs, ...}: {
  vim.lazy.plugins = {
    "grug-far.nvim" = {
      package = pkgs.vimPlugins.grug-far-nvim;
      setupModule = "grug-far";
      setupOpts = {};
      lazy = true;
      keys = [
        {
          key = "<leader>sr";
          mode = ["n" "v"];
          action = ''
            function()
              local grug = require("grug-far")
              local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
              grug.open({
                transient = true,
                prefills = {
                  filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                },
              })
            end
          '';
          lua = true;
          desc = "Search and Replace";
        }
      ];
    };
  };
}
