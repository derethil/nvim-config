{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.mini = {
    bufremove.enable = true;
    files = {
      enable = true;
      setupOpts = {
        windows.preview = false;
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
              return true
            end
          '';
      };
    };
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>e" "<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>" {
      desc = "Open Mini Files (current buffer)";
      silent = true;
    })
    (mkKeymap "n" "<leader>E" "<CMD>lua MiniFiles.open(require('snacks').git.get_root(), false)<CR>" {
      desc = "Open Mini Files (root directory)";
      silent = true;
    })
  ];

  vim.autocmds = [
    {
      event = ["User"];
      pattern = ["MiniFilesActionDelete" "MiniFilesActionMove"];
      desc = "Update buffers after deleting or moving a file";
      callback =
        lib.generators.mkLuaInline
        /*
        lua
        */
        ''
          function(args)
            local action = args.data.action
            local from = args.data.from
            local to = args.data.to

            local bufnr = vim.fn.bufnr(from, true)

            if bufnr ~= -1 then
              require("mini.bufremove").delete(bufnr, true)
              if action == "move" then
                vim.fn.bufadd(to)
              end
            end
          end
        '';
    }
    {
      event = ["User"];
      pattern = ["MiniFilesActionRename"];
      desc = "Attach rename file event to LSP";
      callback = lib.generators.mkLuaInline ''
        function(event)
            require("snacks.rename").on_rename_file(event.data.from, event.data.to)
        end
      '';
    }
  ];
}
