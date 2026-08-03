{
  flake.modules.nvf.tools-file-navigation-buffer-cleanup = {lib, ...}: {
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

        pattern = ["MiniFilesActionDelete" "MiniFilesActionMove"];
        desc = "Update buffers after deleting or moving a file";
      }
    ];
  };
}
