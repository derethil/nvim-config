{
  flake.modules.nvf.tools-file-navigation-setup = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      keymaps = [
        (mkKeymap "n" "<leader>e" "<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>" {
          silent = true;
          desc = "Open Files (current buffer)";
        })
        (mkKeymap "n" "<leader>E" "<CMD>lua MiniFiles.open(require('snacks').git.get_root(), false)<CR>" {
          silent = true;
          desc = "Open Files (root directory)";
        })
      ];

      mini = {
        bufremove.enable = true;

        files = {
          enable = true;

          setupOpts = {
            options.use_as_default_explorer = true;

            content.filter =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function(fs_entry)
                  local hidden = { "__pycache__" }

                  for _, pattern in ipairs(hidden) do
                    if string.match(fs_entry.name, pattern) then
                      return false
                    end
                  end

                  if vim.g.mini_files_show_dotfiles == false then
                    if vim.startswith(fs_entry.name, ".") then
                      return false
                    end
                  end

                  if vim.g.mini_files_show_tests == false then
                    local test_patterns = { "%.spec%.", "%.test%.", "_test%.go$" }
                    for _, pattern in ipairs(test_patterns) do
                      if string.match(fs_entry.name, pattern) then
                        return false
                      end
                    end
                  end

                  return true
                end
              '';

            windows.preview = false;
          };
        };
      };
    };
  };
}
