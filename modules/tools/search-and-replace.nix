{
  flake.modules.nvf.tools-search-and-replace = {pkgs, ...}: {
    vim.lazy.plugins."grug-far.nvim" = {
      package = pkgs.vimPlugins.grug-far-nvim;
      lazy = true;
      setupModule = "grug-far";
      setupOpts = {};

      keys = [
        {
          key = "<leader>sr";

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
          mode = ["n" "v"];
          desc = "Search and Replace";
        }
      ];
    };
  };
}
