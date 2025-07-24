{pkgs}: {
  vim.languages.ts = {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    extraDiagnostics.enable = true;
    format = {
      enable = true;
      type = "prettierd";
      package = pkgs.prettierd;
    };
    extensions = {
      ts-error-translator.enable = true;
    };
  };
}
