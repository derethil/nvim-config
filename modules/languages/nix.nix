{...}: {
  flake.modules.nvf.languages-nix = {
    vim.languages.nix = {
      enable = true;
      lsp = {
        enable = true;
        servers = ["nixd"];
      };
      treesitter = {
        enable = true;
      };
      format = {
        enable = true;
      };
      extraDiagnostics = {
        enable = true;
      };
    };

    vim.lsp = {
      presets.nixd.enable = true;
    };
  };
}
