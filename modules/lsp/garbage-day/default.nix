{
  flake.modules.nvf.lsp-garbage-day = {pkgs, ...}: {
    vim.lazy.plugins.garbage-day-nvim = {
      package = pkgs.internal.garbage-day-nvim;
      setupModule = "garbage-day";
    };
  };
}
