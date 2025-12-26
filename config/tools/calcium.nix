{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.calcium-nvim = {
    package = pkgs.internal.calcium-nvim;
    setupModule = "calcium";
    setupOpts = {
      notifications = true;
      default_mode = "append";
    };
    keys = [
      (mkKeymap "n" "<leader>cc" "<CMD>Calcium<CR>" {desc = "Calculate: Result";})
      (mkKeymap "v" "<leader>cc" ":Calcium replace<CR>" {desc = "Calculate: Result";})
      (mkKeymap "n" "<leader>cC" "<CMD>lua require('calcium').scratchpad()<CR>" {desc = "Calculate: Scratchpad";})
    ];
  };
}
