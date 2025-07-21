{lib, ...}: {
  vim.mini = {
    bufremove.enable = true;
    files = {
      enable = true;
      setupOpts = {
        windows.preview = false;
        options.use_as_default_explorer = true;
      };
    };
  };

  vim.keymaps = [
    {
      key = "<leader>e";
      mode = ["n"];
      action = "<CMD>lua MiniFiles.open()<CR>";
      silent = true;
      desc = "Open Mini Files (current buffer)";
    }
    {
      key = "<leader>E";
      mode = ["n"];
      action = "<CMD>lua MiniFiles.open(require('snacks.git').get_root())<CR>";
      silent = true;
      desc = "Open Mini Files (root directory)";
    }
  ];

  vim.autocmds = [
    {
      event = ["User"];
      pattern = ["MiniFilesActionDelete" "MiniFilesActionMove"];
      desc = "Update buffers after deleting or moving a file";
      callback = lib.generators.mkLuaInline ''
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
