{...}: {
  flake.modules.nvf.languages-json = {
    vim.languages.json = {
      enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
