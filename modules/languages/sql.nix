{...}: {
  flake.modules.nvf.languages-sql = {
    vim.languages.sql = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      format = {
        enable = true;
      };
    };
  };
}
