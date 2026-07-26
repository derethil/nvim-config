{
  flake.modules.nvf.languages-html = {
    vim.languages.html = {
      enable = true;
      extraDiagnostics.enable = true;
      format.enable = true;
      lsp.enable = true;

      treesitter = {
        enable = true;
        autotagHtml = true;
      };
    };
  };
}
