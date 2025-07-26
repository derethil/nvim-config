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
    };

    setupOpts = {
      signature.enabled = true;
      completion = {
        accept.auto_brackets.enabled = true;
        ghost_text.enabled = false;
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 0;
        };
        menu.draw = {
          columns = lib.generators.mkLuaInline ''
            {
              { "kind_icon", "label",  "label_description", gap = 1 },
              { "kind" }
            }
          '';
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
          "path"
          "buffer"
          "yank"
          "snippets"
        ];

        per_filetype = {
          sql = ["copilot" "lsp" "dadbod" "snippets" "buffer"];
        };

        providers = {
          copilot = {
            name = "copilot";
            module = lib.mkForce "blink-cmp-copilot";
            score_offset = 100;
            async = true;
            opts = {
              kind = "copilot";
            };
          };
          lsp = {
            score_offset = 90;
          };
          path = {
            score_offset = 40;
            fallbacks = ["buffer" "snippets" "yank"];
            opts = {
              trailing_slash = false;
              label_trailing_slash = true;
              get_cwd = lib.generators.mkLuaInline ''
                function(context)
                  return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                end
              '';
              show_hidden_files_by_default = true;
            };
          };
          buffer = {
            score_offset = 20;
          };
          snippets = {
            score_offset = 10;
            max_items = 15;
            min_keyword_length = 2;
            # Only show snippets when I type the trigger text
            should_show_items = lib.generators.mkLuaInline ''
              function()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                return before_cursor:match(';' .. "%w*$") ~= nil
              end
            '';
          };
          dadbod = {
            name = "Dadbod";
            module = "vim_dadbod_completion.blink";
            min_keyword_length = 2;
            score_offset = 85;
          };
          emoji = {
            score_offset = 105;
            min_keyword_length = 2;
            opts = {insert = true;};
          };
          yank = {
            name = "yank";
            module = "blink-yanky";
            score_offset = 7;
            max_items = 5;
            min_keyword_length = 3;
            opts = {
              minLength = 4;
              onlyCurrentFiletype = true;
              kind = "yank";
            };
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
