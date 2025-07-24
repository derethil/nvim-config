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
    (lib.util.mkLspCodeAction [
      {
        key = "<leader>co";
        action = "source.organizeImports";
        desc = "Organize Imports";
      }
    ])
  ];
}
