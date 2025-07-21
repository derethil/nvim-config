{pkgs, ...}: {
  vim.lazy.plugins.root-nvim = {
    package = pkgs.internal.root-nvim;
    lazy = true;
  };
}
