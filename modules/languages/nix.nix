{...}: {
  flake.modules.nvf.languages-nix = {
    vim.languages.nix = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      format = {
        enable = true;
      };
    };
  };
}
