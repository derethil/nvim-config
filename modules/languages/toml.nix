{
  flake.modules.nvf.languages-toml = {
    vim.languages.toml = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
