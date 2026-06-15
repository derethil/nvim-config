{...}: {
  flake.modules.nvf.languages-svelte = {
    vim.languages.svelte = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      extraDiagnostics.enable = true;
      format = {
        enable = true;
      };
    };
  };
}
