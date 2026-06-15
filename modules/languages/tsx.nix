{...}: {
  flake.modules.nvf.languages-tsx = {...}: {
    vim.languages.tsx = {
      enable = true;
      lsp = {
        enable = true;
        servers = ["typescript-go"];
      };
      treesitter.enable = true;
      extraDiagnostics.enable = true;
      format = {
        enable = true;
        type = ["prettierd"];
      };
    };
  };
}
