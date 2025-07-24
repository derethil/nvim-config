{lib, ...}: {
  vim.lsp = {
    enable = true;
    formatOnSave = true;
    inlayHints.enable = false;
    lspkind.enable = true;
    mappings = {
      # LSP Specific Mappings
      goToDefinition = "gd";
      goToDeclaration = "gD";
      goToType = "gt";
      listImplementations = null;
      listReferences = null;
      # Diagnostics
      nextDiagnostic = "]d";
      previousDiagnostic = "[d";
      openDiagnosticFloat = "<leader>cd";
      # Document
      documentHighlight = null;
      listDocumentSymbols = null;
      # Workspace Folders
      addWorkspaceFolder = null;
      removeWorkspaceFolder = null;
      listWorkspaceFolders = null;
      listWorkspaceSymbols = null;
      # Actions
      renameSymbol = "<leader>cr";
      codeAction = "<leader>ca";
      # Misc
      signatureHelp = null;
      hover = "K";
      # Formatting
      format = "<leader>cf";
      toggleFormatOnSave = "<leader>cF";
    };
  };

  vim.binds.whichKey.register = {
    "<leader>c" = "+Code";
  };

  vim.autocmds = [
    {
      event = ["LspAttach"];
      desc = "LSP Keymaps";
      callback = lib.generators.mkLuaInline ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end

          local bufnr = args.buf

          -- Organize Imports
          vim.keymap.set("n", "<leader>co", function()
            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
          end, { buffer = bufnr, desc = "Organize Imports" })
        end
      '';
    }
  ];
}
