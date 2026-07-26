{
  flake.modules.nvf.coding-stay-centered = {
    lib,
    pkgs,
    ...
  }: {
    vim = {
      lazy.plugins."stay-centered.nvim" = {
        package = pkgs.vimPlugins.stay-centered-nvim;
        setupModule = "stay-centered";

        setupOpts = {
          allow_scroll_move = false; # workaround for https://github.com/arnamak/stay-centered.nvim/issues/23
        };

        event = [lib.events.VeryLazy];
      };

      # Fixes errors on opening claude-code terminal mode from claude-fzf
      autocmds = [
        {
          event = ["TermOpen"];

          callback = lib.generators.mkLuaInline ''
            function()
              local stay_centered = require('stay-centered')
              if stay_centered.enabled then
                stay_centered.toggle()
              end
            end
          '';

          desc = "Disable stay-centered in terminal buffers";
        }
        {
          event = ["TermClose"];

          callback = lib.generators.mkLuaInline ''
            function()
              local stay_centered = require('stay-centered')
              if not stay_centered.enabled then
                stay_centered.toggle()
              end
            end
          '';

          desc = "Re-enable stay-centered when leaving terminal buffers";
        }
      ];
    };
  };
}
