{
  flake.modules.nvf.languages-docker = {
    vim.languages.docker = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
