{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins."sort-nvim" = {
    package = pkgs.internal.sort-nvim;
    setupModule = "sort";
    cmd = ["Sort"];
    lazy = true;
    keys = [
      (mkKeymap "v" "<leader>h" "<CMD>Sort<CR>" {
        desc = "Sort visual selection";
        silent = true;
      })
    ];
  };
}
