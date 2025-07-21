{lib, ...}: {
  vim.statusline.lualine = {
    enable = true;
    setupOpts = {
      options = {
        component_separators = {
          left = "|";
          right = "";
        };
      };
    };
    activeSection = {
      a = [
        ''
          {
            "mode",
            icons_enabled = true,
          },
        ''
      ];
      b = [];
      c = [
        ''
          {
            "diagnostics",
            sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
            symbols = {error = '${lib.icons.diagnostics.Error} ', warn = '${lib.icons.diagnostics.Warn} ', info = '${lib.icons.diagnostics.Info} ', hint = '${lib.icons.diagnostics.Hint} '},
            colored = true,
            update_in_insert = false,
            always_visible = false,
            diagnostics_color = {
              color_error = { fg = 'red' },
              color_warn = { fg = 'yellow' },
              color_info = { fg = 'cyan' },
            }
          }
        ''
        ''
          {
            "filetype",
            colored = true,
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
            icon = { align = 'left' }
          }
        ''
        ''
          {
            "filename"
          }
        ''
        ''
          {
            "diff",
            colored = true,
            diff_color = {
              added    = 'DiffAdded',
              modified = 'DiffChanged',
              removed  = 'DiffRemoved',
            },
            symbols = {added = '${lib.icons.git.added}', modified = '${lib.icons.git.modified}', removed = '${lib.icons.git.removed}'},
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end
          }
        ''
        ''
          {
            require("gitblame").get_current_blame_text,
            cond = require("gitblame").is_blame_text_available,
            fmt = function(blame)
              local truncate_at = 80
              if #blame > truncate_at then
                blame = blame:sub(1, truncate_at) .. "..."
              end
              return blame
            end
          }
        ''
      ];
      x = [
        ''
          {
            -- Lsp server name
            function()
              local buf_ft = vim.bo.filetype
              local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

              if excluded_buf_ft[buf_ft] then
                return ""
                end

              local bufnr = vim.api.nvim_get_current_buf()
              local clients = vim.lsp.get_clients({ bufnr = bufnr })

              if vim.tbl_isempty(clients) then
                return "No Active LSP"
              end

              local active_clients = {}
              for _, client in ipairs(clients) do
                table.insert(active_clients, client.name)
              end

              return table.concat(active_clients, ", ")
            end,
            icon = ' ',
            separator = ""
          }
        ''
      ];
      y = [
        ''
          {
            "progress",
            separator = { left = "", right = nil }
          }
        ''
        ''
          {
            "location",
            separator = { left = nil, right = nil }
          }
        ''
        ''
          {
            function() return vim.fn.wordcount()["words"] .. " words" end,
            cond = function()
              local count = { latex = true, tex = true, text = true, markdown = true, vimwiki = true }
              return count[vim.bo.filetype] ~= nil
            end,
          }
        ''
      ];
      z = [
        ''
          {
            "branch",
            separator = { left = "", right = nil }
          }
        ''
      ];
    };
  };
}
