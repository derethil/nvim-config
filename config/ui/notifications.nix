{lib, ...}: {
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

  # HACK: the builtin option doesn't seem to work
  # vim.luaConfigRC.fidget_notify = ''
  #   vim.notify = require("fidget").notify
  # '';
}
