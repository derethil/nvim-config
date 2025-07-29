{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.binds.whichKey.register = {
    "<leader>t" = "Database";
  };

  vim.lazy.plugins = {
    vim-dadbod = {
      package = pkgs.vimPlugins.vim-dadbod;
      lazy = true;
    };

    vim-dadbod-completion = {
      package = pkgs.vimPlugins.vim-dadbod-completion;
      ft = ["sql" "mysql" "plsql"];
      lazy = true;
    };

    vim-dadbod-ui = {
      package = pkgs.vimPlugins.vim-dadbod-ui;
      cmd = ["DBUI" "DBUIToggle" "DBUIAddConnection" "DBUIFindBuffer"];
      before = ''
        -- Load dependencies first
        require("lz.n").trigger_load("vim-dadbod")
        require("lz.n").trigger_load("vim-dadbod-completion")

        -- Configuration
        local data_path = vim.fn.stdpath("data")

        vim.g.db_ui_auto_execute_table_helpers = 1
        vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
        vim.g.db_ui_show_database_icon = true
        vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
        vim.g.db_ui_use_nerd_fonts = true
        vim.g.db_ui_use_nvim_notify = true

        -- NOTE: The default behavior of auto-execution of queries on save is disabled
        -- this is useful when you have a big query that you don't want to run every time
        -- you save the file running those queries can crash neovim to run use the
        -- default keymap: <leader>S
        vim.g.db_ui_execute_on_save = false
      '';
      keys = [
        {
          key = "<leader>td";
          mode = ["n"];
          action = ''
            function()
              local function is_dadbod_closed()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.api.nvim_buf_is_loaded(buf) then
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if string.find(buf_name, "dbui") then
                      return false
                    end
                  end
                end
                return true
              end

              -- if dbui is closed, open it
              if is_dadbod_closed() then
                vim.cmd("DBUI")
                return
              end

              -- if dbui is open, close all dbui buffers
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                  local buf_name = vim.api.nvim_buf_get_name(buf)
                  local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

                  if buf_name:find("dbout") or ft == "sql" then
                    vim.api.nvim_buf_delete(buf, { force = true })
                  end
                end
              end

              -- finally, close dbui itself
              vim.cmd("DBUIClose")
            end
          '';
          lua = true;
          desc = "Toggle Dadbod UI";
        }
        (mkKeymap "n" "<leader>tf" "<cmd>DBUIFindBuffer<cr>" {desc = "Find Dadbod Buffer";})
        (mkKeymap "n" "<leader>ta" "<cmd>DBUIAddConnection<cr>" {desc = "Add Dadbod Connection";})
      ];
    };
  };
}
