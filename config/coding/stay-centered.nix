{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins."stay-centered.nvim" = {
    package = pkgs.vimPlugins.stay-centered-nvim;
    event = [lib.events.VeryLazy];
    setupModule = "stay-centered";
    setupOpts = {
      allow_scroll_move = false; # workaround for https://github.com/arnamak/stay-centered.nvim/issues/23
    };
  };

  # Fixes errors on opening claude-code terminal mode from claude-fzf
  vim.autocmds = [
    {
      event = ["TermOpen"];
      desc = "Disable stay-centered in terminal buffers";
      callback = lib.generators.mkLuaInline ''
        function()
          local stay_centered = require('stay-centered')
          if stay_centered.enabled then
            stay_centered.toggle()
          end
        end
      '';
    }
    {
      event = ["TermClose"];
      desc = "Re-enable stay-centered when leaving terminal buffers";
      callback = lib.generators.mkLuaInline ''
        function()
          local stay_centered = require('stay-centered')
          if not stay_centered.enabled then
            stay_centered.toggle()
          end
        end
      '';
    }
  ];
}
