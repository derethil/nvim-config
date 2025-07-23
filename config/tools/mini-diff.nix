{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins."mini.diff" = {
    package = pkgs.vimPlugins.mini-diff;
    setupModule = "mini.diff";
    setupOpts = {
      mappings = {
        apply = "<leader>ghs";
        reset = "<leader>ghr";
        goto_first = "[H";
        goto_prev = "";
        goto_next = "";
        goto_last = "]H";
      };
      view = {
        style = "sign";
        signs = with lib.icons.git.signs; {
          add = added;
          change = modified;
          delete = removed;
        };
      };
    };
    keys = [
      {
        key = "<leader>gd";
        mode = ["n"];
        # Defer the action a bit to give time for mini.diff to initialize
        action = ''
          function()
            vim.defer_fn(function()
              require('mini.diff').toggle_overlay(0)
            end, 100)
          end
        '';
        lua = true;
        desc = "Toggle Buffer Diff";
      }
    ];
  };
}
