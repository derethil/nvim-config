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
      };

      sources = {
        default = [
          "copilot"
          "lsp"
          "ripgrep"
          "snippets"
          "spell"
          "path"
          "buffer"
          "yank"
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
            score_offset = 7;
            min_keyword_length = 2;
            async = true;
          };
          lsp = {
            min_keyword_length = 3;
            score_offset = 6;
          };
          snippets = {
            min_keyword_length = 2;
            score_offset = 5;
          };
          ripgrep = {
            min_keyword_length = 3;
            score_offset = 4;
          };
          spell = {
            min_keyword_length = 3;
            score_offset = 3;
          };
          path = {
            min_keyword_length = 3;
            score_offset = 2;
          };
          buffer = {
            min_keyword_length = 5;
            score_offset = 1;
          };
          yank = {
            name = "yank";
            module = "blink-yanky";
            score_offset = 4;
            opts = {
              minLength = 5;
              onlyCurrentFiletype = true;
              trigger_characters = [];
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
