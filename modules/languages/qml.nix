{...}: {
  flake.modules.nvf.languages-qml = {pkgs, ...}: {
    vim.languages.qml = {
      enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
  };
}
