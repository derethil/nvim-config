{...}: {
  flake.modules.nvf.coding-beam-nvim = {pkgs, ...}: {
    vim.lazy.plugins.beam-nvim = {
      package = pkgs.internal.beam-nvim;
      setupModule = "beam";
    };
  };
}
