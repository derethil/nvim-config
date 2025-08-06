{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.kulala-nvim = {
    package = pkgs.internal.kulala-nvim;
    setupModule = "kulala";
    setupOpts = {
      global_keymaps = true;
      global_keymaps_prefix = "<leader>r";
    };
    keys = [
      (mkKeymap "n" "<leader>ro" "<CMD>:lua require('kulala').toggle()<CR>" {desc = "Open Kuala";})
    ];
  };

  vim.luaConfigRC.kulala_filetype = ''
    vim.filetype.add({
      extension = {
        ['http'] = 'http',
      },
    })
  '';

  vim.extraPackages = with pkgs; [
    curlMinimal
    grpcurl
    websocat
    jq
  ];
}
