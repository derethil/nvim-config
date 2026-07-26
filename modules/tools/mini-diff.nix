{
  flake.modules.nvf.tools-mini-diff = {
    lib,
    pkgs,
    ...
  }: {
    vim.lazy.plugins."mini.diff" = {
      package = pkgs.vimPlugins.mini-diff;
      setupModule = "mini.diff";

      setupOpts = {
        mappings = {
          apply = "<leader>ghs";
          goto_first = "[H";
          goto_last = "]H";
          goto_next = "";
          goto_prev = "";
          reset = "<leader>ghr";
        };

        view = {
          signs = with lib.icons.git.signs; {
            add = added;
            change = modified;
            delete = removed;
          };

          style = "sign";
        };
      };

      keys = [
        {
          key = "<leader>gd";

          action = ''
            function()
              vim.defer_fn(function()
                require('mini.diff').toggle_overlay(0)
              end, 100)
            end
          '';

          lua = true;
          mode = ["n"];
          desc = "Toggle Buffer Diff";
        }
      ];
    };
  };
}
