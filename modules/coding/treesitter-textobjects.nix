{...}: {
  flake.modules.nvf.coding-treesitter-textobjects = {
    vim.treesitter.textobjects = {
      enable = true;
    };
  };
}
