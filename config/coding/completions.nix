{
  vim.autocomplete.blink-cmp = {
    enable = true;

    friendly-snippets.enable = true;

    mappings = {
      close = "<Esc>";
      complete = "<C-e>";
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
      completion = {
        accept = {
          auto_brackets = {
            enabled = true;
          };
        };

        menu = {
          auto_show = true;
          draw = {
            treesitter = ["lsp"];
          };
        };

        documentation.auto_show = true;
        ghost_text. enabled = true;
      };

      sources = {
        default = [
          "lsp"
          "snippets"
          "spell"
          "path"
          "buffer"
        ];

        providers = {
          lsp = {
            min_keyword_length = 3;
            score_offset = 5;
          };
          snippets = {
            min_keyword_length = 2;
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
        };
      };

      cmdline.keymap.preset = "none";
    };
  };
}
