{
  vim.visuals.fidget-nvim = {
    enable = true;
    setupOpts = {
      notification = {
        override_vim_notify = true;
        window.winblend = 0;
      };
    };
  };

  # HACK: the builtin opption doesn't seem to work
  vim.luaConfigRC.fidget_notify = ''
    vim.notify = require("fidget").notify
  '';
}
