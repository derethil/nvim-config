{
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

  # HACK: No idea why, but the config option for this doesn't work
  vim.luaConfigRC.fidget_notify = ''
    vim.notify = require("fidget").notify
  '';
}
