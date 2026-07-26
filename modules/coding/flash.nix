{
  flake.modules.nvf.coding-flash = {
    vim.utility.motion.flash-nvim = {
      enable = true;

      mappings = {
        jump = "s";
        remote = "r";
        toggle = "<C-s>";
        treesitter = "S";
        treesitter_search = "R";
      };
    };
  };
}
