{pkgs, ...}: {
  vim.extraPlugins.root-nvim = {
    package = pkgs.internal.root-nvim;
  };
}
