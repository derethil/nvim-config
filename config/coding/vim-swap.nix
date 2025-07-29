{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.vim-swap = {
    package = pkgs.vimPlugins.vim-swap;
    lazy = true;
    keys = [
      (mkKeymap "n" "<leader>c<" "<Plug>(swap-prev)" {desc = "Swap with Prev";})
      (mkKeymap "n" "<leader>c>" "<Plug>(swap-next)" {desc = "Swap with Next";})
      (mkKeymap "n" "<leader>ci" "<Plug>(swap-interactive)" {desc = "Interactive Swap";})
    ];
  };
}
