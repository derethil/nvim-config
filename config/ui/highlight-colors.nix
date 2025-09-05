{
  pkgs,
  lib,
  ...
}: {
  # TODO:: v0.8 has nvim-highlight-color options included by default, migrate to that

  vim.lazy.plugins."nvim-highlight-colors" = {
    package = pkgs.vimPlugins.nvim-highlight-colors;
    event = [lib.events.VeryLazy];
    ft = ["typescriptreact" "javascriptreact" "css" "javascript" "typescript" "html"];
    setupModule = "nvim-highlight-colors";
    setupOpts = {
      render = "virtual";
      virtual_symbol = "";
      enable_named_colors = true;
      enable_tailwind = true;
    };
  };
}
