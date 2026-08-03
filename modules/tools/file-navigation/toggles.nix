{
  flake.modules.nvf.tools-file-navigation-test-toggle = {lib, ...}: {
    vim.autocmds = [
      {
        event = ["User"];

        callback =
          lib.generators.mkLuaInline
          /*
          lua
          */
          ''
            function(args)
              local win_id = args.data.win_id

              local state = MiniFiles.get_explorer_state()
              local dir_path = nil
              for i, win_info in ipairs(state.windows) do
                if win_info.win_id == win_id then
                  dir_path = state.branch[i]
                  break
                end
              end
              if not dir_path then return end

              local footer_parts = {}

              local ok, entries = pcall(vim.fn.readdir, dir_path)
              if ok then
                local test_count = 0
                local dot_count = 0

                local test_patterns = { "%.spec%.", "%.test%.", "_test%.go$" }

                for _, name in ipairs(entries) do
                  if vim.g.mini_files_show_tests == false then
                    for _, pattern in ipairs(test_patterns) do
                      if string.match(name, pattern) then
                        test_count = test_count + 1
                        break
                      end
                    end
                  end

                  if vim.g.mini_files_show_dotfiles == false then
                    if vim.startswith(name, ".") then
                      dot_count = dot_count + 1
                    end
                  end
                end

                if test_count > 0 then
                  table.insert(footer_parts, { " +" .. test_count .. " tests ", "Comment" })
                end

                if dot_count > 0 then
                  table.insert(footer_parts, { " +" .. dot_count .. " dots ", "Comment" })
                end
              end

              local config = vim.api.nvim_win_get_config(win_id)
              if #footer_parts == 0 then
                config.footer = ""
              else
                config.footer = footer_parts
                config.footer_pos = "left"
              end
              vim.api.nvim_win_set_config(win_id, config)
            end
          '';

        pattern = ["MiniFilesWindowUpdate"];
        desc = "Show hidden file counts in window footer";
      }
      {
        event = ["User"];

        callback =
          lib.generators.mkLuaInline
          /*
          lua
          */
          ''
            function(args)
              local buf_id = args.data.buf_id
              local hidden = { "__pycache__" }

              if vim.g.mini_files_show_tests == nil then
                vim.g.mini_files_show_tests = false
              end

              if vim.g.mini_files_show_dotfiles == nil then
                vim.g.mini_files_show_dotfiles = false
              end

              local combined_filter = function(fs_entry)
                for _, pattern in ipairs(hidden) do
                  if string.match(fs_entry.name, pattern) then return false end
                end

                if vim.g.mini_files_show_dotfiles == false then
                  if vim.startswith(fs_entry.name, ".") then return false end
                end

                if vim.g.mini_files_show_tests == false then
                  local test_patterns = { "%.spec%.", "%.test%.", "_test%.go$" }
                  for _, pattern in ipairs(test_patterns) do
                    if string.match(fs_entry.name, pattern) then return false end
                  end
                end

                return true
              end

              local toggle_tests = function()
                vim.g.mini_files_show_tests = not vim.g.mini_files_show_tests
                MiniFiles.refresh({ content = { filter = combined_filter } })
              end

              local toggle_dots = function()
                vim.g.mini_files_show_dotfiles = not vim.g.mini_files_show_dotfiles
                MiniFiles.refresh({ content = { filter = combined_filter } })
              end

              vim.keymap.set("n", "<leader>u", toggle_tests, { buffer = buf_id, desc = "Toggle test files" })
              vim.keymap.set("n", "<leader>.", toggle_dots, { buffer = buf_id, desc = "Toggle dotfiles" })
            end
          '';

        pattern = ["MiniFilesBufferCreate"];
        desc = "Toggle file visibility with keymaps";
      }
    ];
  };
}
