{
  pkgs,
  lib,
  ...
}:
with pkgs.vimPlugins; {
  vim.lazy.plugins = {
    "barbecue.nvim" = {
      package = barbecue-nvim;
      setupModule = "barbecue";
      event = [lib.events.VeryLazy];
    };
  };
}
