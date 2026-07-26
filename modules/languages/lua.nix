{
  flake.modules.nvf.languages-lua = {
    vim.languages.lua = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
