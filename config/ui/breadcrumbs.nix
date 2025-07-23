{
  pkgs,
  lib,
  ...
}:
with pkgs.vimPlugins; {
  vim.lazy.plugins = {
    nvim-navic = {
      package = nvim-navic;
      setupModule = "nvim-navic";
      setupOpts = {};
      event = [lib.events.VeryLazy];
    };
    "barbecue.nvim" = {
      package = barbecue-nvim;
      setupModule = "barbecue";
      event = [lib.events.VeryLazy];
    };
  };
}
