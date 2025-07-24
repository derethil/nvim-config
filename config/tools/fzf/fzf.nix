{
  pkgs,
  lib,
  ...
}: {
  vim.extraPackages = with pkgs; [
    chafa
    diff-so-fancy
  ];

  vim.lazy.plugins.import-nvim = {
    package = pkgs.internal.import-nvim;
    setupModule = "import";
    setupOpts.picker = "fzf-lua";
    priority = 10; # load after fzf-lua
    keys = [
      {
        key = "<leader>si";
        mode = ["n"];
        action = "function() require('import').pick() end";
        lua = true;
        desc = "Search Imports";
      }
    ];
  };

  vim.lazy.plugins.fzf-lua = {
    package = pkgs.vimPlugins.fzf-lua;
    setupModule = "fzf-lua";
    event = [lib.events.VeryLazy];
    setupOpts =
      {"@1" = "default-title";} # first argument is the default profile, not a table
      // {
        fzf_colors = true;
        fzf_opts = {"--no-scrollbar" = true;};
        defaults = {
          formatter = "path.dirname_first";
          previewr = true;
          preview_pager = "diff-so-fancy";
        };
        previewers = {
          builtin = {
            extensions = let
              image-previewer = {
                cmd = "chafa";
                args = [];
              };
            in {
              png = image-previewer;
              jpg = image-previewer;
              jpeg = image-previewer;
              gif = image-previewer;
              webp = image-previewer;
            };
          };
        };
        files = {
          cwd_prompt = false;
          actions = {
            "alt-i" = ["require('fzf-lua').actions.toggle_ignore"];
            "alt-h" = ["require('fzf-lua').actions.toggle_hidden"];
          };
        };
        grep = {
          actions = {
            "alt-i" = ["require('fzf-lua').actions.toggle_ignore"];
            "alt-h" = ["require('fzf-lua').actions.toggle_hidden"];
          };
        };
        lsp = {
          symbols = {
            symbol_hl = ''
              function(s)
                return "TroubleIcon" .. s
              end'';
            symbol_fmt = ''
              function(s)
                return s:lower() .. "\t"
              end'';
            child_prefix = false;
          };
          code_actions = {
            previewer = lib.generators.mkLuaInline "vim.fn.executable('diff-so-fancy') == 1 and 'codeaction_native' or nil";
            winopts = {
              layout = "vertical";
              width = 0.5;
              height = 0.8;
              preview = {
                layout = "vertical";
                vertical = "down:15,border-top";
                hidden = "hidden";
              };
            };
          };
        };
        # Custom ui_select configuration for better code actions
        ui_select = lib.generators.mkLuaInline ''
          function(fzf_opts, items)
            return vim.tbl_deep_extend("force", fzf_opts, {
              prompt = " ",
              winopts = {
                title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
                title_pos = "center",
              },
            }, fzf_opts.kind == "codeaction" and {
              winopts = {
                layout = "vertical",
                -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
                height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
                width = 0.5,
                preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "ts_ls" })) and {
                  layout = "vertical",
                  vertical = "down:15,border-top",
                  hidden = "hidden",
                } or {
                  layout = "vertical",
                  vertical = "down:15,border-top",
                },
              },
            } or {
              winopts = {
                width = 0.5,
                -- height is number of items, with a max of 80% screen height
                height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
              },
            })
          end
        '';
      };
    after = ''
      vim.cmd("FzfLua register_ui_select")
    '';
    keys = [
      # Shortcuts
      {
        key = "<leader>,";
        mode = ["n"];
        action = "<CMD>FzfLua buffers sort_mru=true sort_lastused=true<CR>";
        desc = "Switch Buffer";
      }
      {
        key = "<leader>/";
        mode = ["n"];
        action = "function() require('fzf-lua').live_grep({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Grep (root directory)";
      }
      {
        key = "<leader>:";
        mode = ["n"];
        action = "<CMD>FzfLua command_history<CR>";
        desc = "Command History";
      }
      {
        key = "<leader><space>";
        mode = ["n"];
        action = "function() require('fzf-lua').files({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Files (root directory)";
      }
      # Files
      {
        key = "<leader>ff";
        mode = ["n"];
        action = "function() require('fzf-lua').files({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Files (root directory)";
      }
      {
        key = "<leader>fF";
        mode = ["n"];
        action = "function() require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') }) end";
        lua = true;
        desc = "Files (buffer directory)";
      }
      {
        key = "<leader>fg";
        mode = ["n"];
        action = "<CMD>FzfLua git_files<cr>";
        desc = "Find Files (git)";
      }
      {
        key = "<leader>fr";
        mode = ["n"];
        action = "<CMD>FzfLua oldfiles<cr>";
        desc = "Find Recent Files";
      }
      {
        key = "<leader>fR";
        mode = ["n"];
        action = "function() require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') }) end";
        lua = true;
        desc = "Find Recent Files (buffer directory)";
      }
      # Git
      {
        key = "<leader>gc";
        mode = ["n"];
        action = "<CMD>FzfLua git_commits<CR>";
        desc = "Git Commits";
      }
      {
        key = "<leader>gs";
        mode = ["n"];
        action = "<CMD>FzfLua git_status<CR>";
        desc = "Git Status";
      }
      # Miscellaneous
      {
        key = "<leader>sb";
        mode = ["n"];
        action = "<CMD>FzfLua builtin<CR>";
        desc = "Search Builtins";
      }
      {
        key = "<leader>sb";
        mode = ["n"];
        action = "<CMD>FzfLua grep_curbuf<CR>";
        desc = "Search Buffer";
      }
      {
        key = "<leader>sC";
        mode = ["n"];
        action = "<CMD>FzfLua commands<CR>";
        desc = "Search Commands";
      }
      {
        key = "<leader>sd";
        mode = ["n"];
        action = "<CMD>FzfLua diagnostics_document<CR>";
        desc = "Search Diagnostics (document)";
      }
      {
        key = "<leader>sD";
        mode = ["n"];
        action = "<CMD>FzfLua diagnostics_workspace<CR>";
        desc = "Search Diagnostics (workspace)";
      }
      {
        key = "<leader>sg";
        mode = ["n"];
        action = "function() require('fzf-lua').live_grep({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Search Grep (root directory)";
      }
      {
        key = "<leader>sG";
        mode = ["n"];
        action = "function() require('fzf-lua').live_grep({ cwd = vim.fn.expand('%:p:h') }) end";
        lua = true;
        desc = "Search Grep (buffer directory)";
      }
      {
        key = "<leader>sh";
        mode = ["n"];
        action = "<CMD>FzfLua help_tags<CR>";
        desc = "Search Help Pages";
      }
      {
        key = "<leader>sH";
        mode = ["n"];
        action = "<CMD>FzfLua highlights<CR>";
        desc = "Search Highlight Groups";
      }
      {
        key = "<leader>sk";
        mode = ["n"];
        action = "<CMD>FzfLua keymaps<CR>";
        desc = "Search Keymaps";
      }
      {
        key = "<leader>sm";
        mode = ["n"];
        action = "<CMD>FzfLua marks<CR>";
        desc = "Search Marks";
      }
      {
        key = "<leader>sR";
        mode = ["n"];
        action = "<CMD>FzfLua resume<CR>";
        desc = "Resume Search";
      }
      {
        key = "<leader>sq";
        mode = ["n"];
        action = "<CMD>FzfLua quickfix<CR>";
        desc = "Search Quickfix List";
      }
      {
        key = "<leader>sw";
        mode = ["n"];
        action = "function() require('fzf-lua').grep_cword({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Search Word (root directory)";
      }
      {
        key = "<leader>sW";
        mode = ["n"];
        action = "function() require('fzf-lua').grep_cword({ cwd = vim.fn.expand('%:p:h') }) end";
        lua = true;
        desc = "Search Word (buffer directory)";
      }
      {
        key = "<leader>sw";
        mode = ["v"];
        action = "function() require('fzf-lua').grep_visual({ cwd = require('root').get() }) end";
        lua = true;
        desc = "Search Visual Selection (root directory)";
      }
      {
        key = "<leader>sW";
        mode = ["v"];
        action = "function() require('fzf-lua').grep_visual({ cwd = vim.fn.expand('%:p:h') }) end";
        lua = true;
        desc = "Search Visual Selection (buffer directory)";
      }
      {
        key = "<leader>ss";
        mode = ["n"];
        action = "<CMD>FzfLua lsp_document_symbols<CR>";
        desc = "Search Symbols";
      }
      {
        key = "<leader>sS";
        mode = ["n"];
        action = "<CMD>FzfLua lsp_workspace_symbols<CR>";
        desc = "Search Symbols (workspace)";
      }
    ];
  };
}
