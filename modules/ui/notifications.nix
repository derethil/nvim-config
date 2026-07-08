{...}: {
  flake.modules.nvf.ui-notifications = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.visuals.fidget-nvim = {
      enable = true;
      setupOpts = {
        notification = {
          override_vim_notify = false;
          window.winblend = 0;
        };
        logger = {
          level = "trace";
        };
      };
    };

    vim.keymaps = [
      (mkKeymap "n" "<leader>n" "<CMD>Fidget history<CR>" {desc = "Notification History";})
    ];

    # this option in setupOpts doesn't work due to lazy loading
    vim.luaConfigRC.fidget_notify = ''vim.notify = require("fidget").notify '';
  };
}
