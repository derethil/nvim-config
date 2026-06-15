{...}: {
  flake.modules.nvf.languages-just = {
    vim.languages.just = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
