{
  flake.modules.nvf.coding-sort = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.lazy.plugins."sort-nvim" = {
      package = pkgs.internal.sort-nvim;
      lazy = true;
      setupModule = "sort";
      cmd = ["Sort"];

      keys = [
        (mkKeymap "v" "<leader>h" "<CMD>Sort<CR>" {
          silent = true;
          desc = "Sort visual selection";
        })
      ];
    };
  };
}
