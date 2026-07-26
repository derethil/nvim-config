{
  flake.modules.nvf.ui-cursorline = {
    vim.visuals.nvim-cursorline = {
      enable = true;

      setupOpts = {
        cursorline = {
          enable = true;
          timeout = 0;
        };

        cursorword = {
          enable = true;
          timeout = 0;
        };
      };
    };
  };
}
