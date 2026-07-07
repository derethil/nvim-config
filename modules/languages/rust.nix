{...}: {
  flake.modules.nvf.languages-rust = {
    vim.languages.rust = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      format.enable = true;
      dap.enable = true;
      extensions = {
        crates-nvim.enable = true;
      };
    };
  };
}
