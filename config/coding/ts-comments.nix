{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins = {
    "ts-comments.nvim" = {
      package = pkgs.vimPlugins.ts-comments-nvim;
      setupModule = "ts-comments";
      setupOpts = {};
      lazy = true;
      event = [lib.events.VeryLazy];
    };
  };
}
