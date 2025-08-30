{pkgs, ...}: {
  vim.lazy.plugins.beam-nvim = {
    package = pkgs.internal.beam-nvim;
    setupModule = "beam";
  };
}
