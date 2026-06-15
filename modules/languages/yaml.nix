{...}: {
  flake.modules.nvf.languages-yaml = {
    vim.languages.yaml = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
