{
  flake.modules.nvf.coding-completions = {
    lib,
    pkgs,
    ...
  }: {
    vim = {
      lazy.plugins = {
        "blink-cmp-conventional-commits" = {
          package = pkgs.vimPlugins.blink-cmp-conventional-commits;
          priority = 100; # load before blink-cmp
        };

        "blink-cmp-yanky" = {
          package = pkgs.vimPlugins.blink-cmp-yanky;
          priority = 100; # load before blink-cmp
        };

        "colorful-menu.nvim" = {
          package = pkgs.vimPlugins.colorful-menu-nvim;
          setupModule = "colorful-menu";
          setupOpts = {};
          event = [lib.events.VeryLazy];
        };
      };

      autocomplete.blink-cmp = {
        enable = true;

        setupOpts = {
          cmdline.keymap.preset = "none";

          completion = {
            accept.auto_brackets.enabled = true;

            documentation = {
              auto_show = true;
              auto_show_delay_ms = 0;
            };

            ghost_text = {
              enabled = true;
              show_with_menu = true;
            };

            menu = {
              auto_show = true;
              direction_priority = ["n" "s"];

              draw = {
                columns = lib.generators.mkLuaInline ''
                  {
                    { "kind_icon", "label", gap = 1 },
                  }
                '';

                components = {
                  kind.highlight = lib.generators.mkLuaInline ''
                    function(ctx)
                      local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                      return hl
                    end
                  '';

                  kind_icon = {
                    highlight = lib.generators.mkLuaInline ''
                      function(ctx)
                        local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                        return hl
                      end
                    '';

                    text = lib.generators.mkLuaInline ''
                      function(ctx)
                        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                        return kind_icon
                      end
                    '';
                  };

                  label = {
                    highlight = lib.generators.mkLuaInline ''
                      function(ctx)
                        return require("colorful-menu").blink_components_highlight(ctx)
                      end
                    '';

                    text = lib.generators.mkLuaInline ''
                      function(ctx)
                        return require("colorful-menu").blink_components_text(ctx)
                      end
                    '';
                  };
                };
              };
            };
          };

          signature.enabled = true;

          sources = {
            default = [
              "copilot"
              "conventional_commits"
              "lsp"
              "path"
              "buffer"
              "yank"
              "snippets"
            ];

            per_filetype.sql = ["copilot" "lsp" "dadbod" "snippets" "buffer"];

            providers = {
              buffer.score_offset = 20;

              conventional_commits = {
                enabled = lib.generators.mkLuaInline ''
                  function()
                    return vim.bo.filetype == "gitcommit"
                  end
                '';

                module = "blink-cmp-conventional-commits";
                name = "Conventional Commits";

                opts.completion.items = [
                  {
                    doc = "Commits that only affect build-related components";
                    type = "build";
                  }
                  {
                    doc = "Commits that only affect operational components";
                    type = "ops";
                  }
                ];

                score_offset = 1000;
              };

              copilot = {
                async = true;
                module = lib.mkForce "blink-cmp-copilot";
                name = "copilot";
                opts.kind = "copilot";
                score_offset = 1000;
              };

              dadbod = {
                min_keyword_length = 2;
                module = "vim_dadbod_completion.blink";
                name = "Dadbod";
                score_offset = 85;
              };

              emoji = {
                min_keyword_length = 2;
                opts.insert = true;
                score_offset = 10000000;
              };

              lsp.score_offset = 90;

              path = {
                fallbacks = ["buffer" "snippets" "yank"];

                opts = {
                  get_cwd = lib.generators.mkLuaInline ''
                    function(context)
                      return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                    end
                  '';

                  label_trailing_slash = true;
                  show_hidden_files_by_default = true;
                  trailing_slash = false;
                };

                score_offset = 40;
              };

              snippets = {
                max_items = 15;
                min_keyword_length = 2;
                score_offset = 10;

                # Only show snippets when I type the trigger text
                should_show_items = lib.generators.mkLuaInline ''
                  function()
                    local col = vim.api.nvim_win_get_cursor(0)[2]
                    local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                    return before_cursor:match(';' .. "%w*$") ~= nil
                  end
                '';
              };

              yank = {
                max_items = 5;
                min_keyword_length = 3;
                module = "blink-yanky";
                name = "yank";

                opts = {
                  kind = "yank";
                  minLength = 4;
                  onlyCurrentFiletype = true;
                };

                score_offset = 7;
              };
            };
          };
        };

        friendly-snippets.enable = true;

        mappings = {
          close = "<C-e>";
          complete = "<C-j>";
          confirm = "<C-y>";
          next = "<C-n>";
          previous = "<C-p>";
          scrollDocsDown = "<C-f>";
          scrollDocsUp = "<C-b>";
        };

        sourcePlugins.emoji.enable = true;
      };
    };
  };
}
