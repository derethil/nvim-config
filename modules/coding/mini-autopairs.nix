{
  flake.modules.nvf.coding-mini-autopairs = {
    vim.mini.pairs = {
      enable = false;

      setupOpts = {
        markdown = true;

        modes = {
          command = false;
          insert = true;
          terminal = false;
        };

        skip_next = ''[=[[%w%%%'%[%"%.%`%$]]=]'';
        skip_ts = ["string"];
        skip_unbalanced = true;
      };
    };
  };
}
