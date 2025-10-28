{
  pkgs,
  lib,
  ...
}: {
  # nvf 0.8 has a module builtin, but this way it's lazy-loaded
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
