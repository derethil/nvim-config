{
  vim.fzf-lua = {
    enable = true;
    profile = "default-title";
    setupOpts = {
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
    };
  };

  vim.keymaps = [
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
      key = "<leader>fb";
      mode = ["n"];
      action = "<CMD>FzfLua builtin<CR>";
      desc = "Find Builtins";
    }
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
}
