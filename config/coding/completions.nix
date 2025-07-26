{
  lib,
  pkgs,
  ...
}: {
  vim.autocomplete.blink-cmp = {
    enable = true;

    friendly-snippets.enable = true;
    mappings = {
      close = "<C-e>";
      complete = null;
      confirm = "<C-y>";
      next = "<C-n>";
      previous = "<C-p>";
      scrollDocsDown = "<C-f>";
      scrollDocsUp = "<C-b>";
    };

    sourcePlugins = {
      emoji.enable = true;
      ripgrep.enable = true;
      spell.enable = true;
    };

    setupOpts = {
      signature.enabled = true;
      completion = {
        accept.auto_brackets.enabled = true;
        ghost_text.enabled = true;
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 0;
        };
        menu.draw = {
          components = {
            kind_icon = {
              text = lib.generators.mkLuaInline ''
                function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end
              '';
              highlight = lib.generators.mkLuaInline ''
                function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end
              '';
            };
            kind = {
              highlight = lib.generators.mkLuaInline ''
                function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end
              '';
            };
          };
        };
      };

      sources = {
        default = [
          "copilot"
          "lsp"
          "buffer"
          "yank"
          "ripgrep"
          "snippets"
          "path"
        ];

        per_filetype = {
          sql = ["copilot" "lsp" "dadbod" "snippets" "buffer"];
        };

        providers = {
          dadbod = {
            name = "Dadbod";
            module = "vim_dadbod_completion.blink";
          };
          copilot = {
            name = "copilot";
            module = lib.mkForce "blink-cmp-copilot";
            score_offset = 10000;
            async = true;
            opts = {
              kind = "copilot";
            };
          };
          lsp = {
            score_offset = 10;
          };
          buffer = {
            score_offset = 9;
          };
          yank = {
            name = "yank";
            module = "blink-yanky";
            score_offset = 8;
            opts = {
              minLength = 4;
              onlyCurrentFiletype = true;
              kind = "yank";
            };
          };
          ripgrep = {
            score_offset = 7;
          };
        };
      };

      cmdline.keymap.preset = "none";
    };
  };

  vim.lazy.plugins."blink-cmp-yanky" = {
    priority = 100; # load before blink-cmp
    package = pkgs.internal.blink-cmp-yanky;
  };
}
