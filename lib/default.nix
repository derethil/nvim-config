{lib}: {
  util = {
    importAllNix = dir:
      builtins.filter (lib.hasSuffix ".nix")
      (lib.filesystem.listFilesRecursive dir);

    createUserCommand = {
      command,
      callback,
      opts ? {},
    }: ''
      vim.api.nvim_create_user_command("${command}", ${callback}, ${lib.generators.toLua {} opts})
    '';

    mkLspCodeAction = keymaps: {
      event = ["LspAttach"];
      desc = "LSP Code Action Keymaps";
      callback = lib.generators.mkLuaInline ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          
          local bufnr = args.buf
          
          ${lib.concatStringsSep "\n          " (map (keymap: 
            let
              clientCheck = if keymap.clientName or null != null then "client.name ~= '${keymap.clientName}'" else "false";
              mode = keymap.mode or "n";
              actionStr = if builtins.isString keymap.action then
                "function() vim.lsp.buf.code_action({ context = { only = { '${keymap.action}' } }, apply = true }) end"
              else if keymap.action._type or "" == "lua-inline" then
                keymap.action.expr
              else
                builtins.toString keymap.action;
            in
            ''
              -- ${keymap.desc}
              if not (${clientCheck}) then
                vim.keymap.set("${mode}", "${keymap.key}", ${actionStr}, { buffer = bufnr, desc = "${keymap.desc}" })
              end
            ''
          ) keymaps)}
        end
      '';
    };

    mkLspAttachCallback = callbacks: {
      event = ["LspAttach"];
      desc = "LSP Attach Callbacks";
      callback = lib.generators.mkLuaInline ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          
          local bufnr = args.buf
          
          ${lib.concatStringsSep "\n          " (map (callback: 
            let
              clientCheck = if callback.clientName or null != null then "client.name ~= '${callback.clientName}'" else "false";
              luaCode = if callback.code._type or "" == "lua-inline" then
                callback.code.expr
              else if builtins.isString callback.code then
                callback.code
              else
                builtins.toString callback.code;
            in
            ''
              -- ${callback.desc or "LSP callback"}
              if not (${clientCheck}) then
                ${luaCode}
              end
            ''
          ) callbacks)}
        end
      '';
    };
  };

  icons = import ./icons.nix;
  events = import ./events.nix;
}
