{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
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
      (mkKeymap "n" "<leader>," "<CMD>FzfLua buffers sort_mru=true sort_lastused=true<CR>" {desc = "Switch Buffer";})
      (mkKeymap "n" "<leader>/" ''<CMD>FzfLua live_grep cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Grep (root directory)";})
      (mkKeymap "n" "<leader>:" "<CMD>FzfLua command_history<CR>" {desc = "Command History";})
      (mkKeymap "n" "<leader><space>" ''<CMD>FzfLua files cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Files (root directory)";})
      # Files
      (mkKeymap "n" "<leader>ff" ''<CMD>FzfLua files cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Files (root directory)";})
      (mkKeymap "n" "<leader>fF" ''<CMD>FzfLua files cwd=<C-R>=expand("%:p:h")<CR><CR>'' {desc = "Files (buffer directory)";})
      (mkKeymap "n" "<leader>fg" "<CMD>FzfLua git_files<cr>" {desc = "Find Files (git)";})
      (mkKeymap "n" "<leader>fr" "<CMD>FzfLua oldfiles<cr>" {desc = "Find Recent Files";})
      (mkKeymap "n" "<leader>fR" ''<CMD>FzfLua oldfiles cwd=<C-R>=expand("%:p:h")<CR><CR>'' {desc = "Find Recent Files (buffer directory)";})
      # Git
      (mkKeymap "n" "<leader>gc" "<CMD>FzfLua git_commits<CR>" {desc = "Git Commits";})
      (mkKeymap "n" "<leader>gs" "<CMD>FzfLua git_status<CR>" {desc = "Git Status";})
      # Miscellaneous
      (mkKeymap "n" "<leader>sb" "<CMD>FzfLua builtin<CR>" {desc = "Search Builtins";})
      (mkKeymap "n" "<leader>sB" "<CMD>FzfLua grep_curbuf<CR>" {desc = "Search Buffer";})
      (mkKeymap "n" "<leader>sC" "<CMD>FzfLua commands<CR>" {desc = "Search Commands";})
      (mkKeymap "n" "<leader>sd" "<CMD>FzfLua diagnostics_document<CR>" {desc = "Search Diagnostics (document)";})
      (mkKeymap "n" "<leader>sD" "<CMD>FzfLua diagnostics_workspace<CR>" {desc = "Search Diagnostics (workspace)";})
      (mkKeymap "n" "<leader>sg" ''<CMD>FzfLua live_grep cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Search Grep (root directory)";})
      (mkKeymap "n" "<leader>sG" ''<CMD>FzfLua live_grep cwd=<C-R>=expand("%:p:h")<CR><CR>'' {desc = "Search Grep (buffer directory)";})
      (mkKeymap "n" "<leader>sh" "<CMD>FzfLua help_tags<CR>" {desc = "Search Help Pages";})
      (mkKeymap "n" "<leader>sH" "<CMD>FzfLua highlights<CR>" {desc = "Search Highlight Groups";})
      (mkKeymap "n" "<leader>sk" "<CMD>FzfLua keymaps<CR>" {desc = "Search Keymaps";})
      (mkKeymap "n" "<leader>sm" "<CMD>FzfLua marks<CR>" {desc = "Search Marks";})
      (mkKeymap "n" "<leader>sR" "<CMD>FzfLua resume<CR>" {desc = "Resume Search";})
      (mkKeymap "n" "<leader>sq" "<CMD>FzfLua quickfix<CR>" {desc = "Search Quickfix List";})
      (mkKeymap "n" "<leader>sw" ''<CMD>FzfLua grep_cword cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Search Word (root directory)";})
      (mkKeymap "n" "<leader>sW" ''<CMD>FzfLua grep_cword cwd=<C-R>=expand("%:p:h")<CR><CR>'' {desc = "Search Word (buffer directory)";})
      (mkKeymap "v" "<leader>sw" ''<CMD>FzfLua grep_visual cwd=<C-R>=luaeval("require('root').get()")<CR><CR>'' {desc = "Search Visual Selection (root directory)";})
      (mkKeymap "v" "<leader>sW" ''<CMD>FzfLua grep_visual cwd=<C-R>=expand("%:p:h")<CR><CR>'' {desc = "Search Visual Selection (buffer directory)";})
      (mkKeymap "n" "<leader>ss" "<CMD>FzfLua lsp_document_symbols<CR>" {desc = "Search Symbols";})
      (mkKeymap "n" "<leader>sS" "<CMD>FzfLua lsp_workspace_symbols<CR>" {desc = "Search Symbols (workspace)";})
    ];
  };
}
