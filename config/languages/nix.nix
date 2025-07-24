{pkgs, ...}: {
  vim.languages.nix = {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
      package = pkgs.alejandra;
    };
  };
}
