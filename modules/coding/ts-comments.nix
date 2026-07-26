{
  flake.modules.nvf.coding-ts-comments = {
    lib,
    pkgs,
    ...
  }: {
    vim.lazy.plugins."ts-comments.nvim" = {
      package = pkgs.vimPlugins.ts-comments-nvim;
      lazy = true;
      setupModule = "ts-comments";
      setupOpts = {};
      event = [lib.events.VeryLazy];
    };
  };
}
