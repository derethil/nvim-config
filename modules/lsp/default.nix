{
  flake.modules.nvf.lsp-default = {lib, ...}: {
    vim = {
      autocmds = [
        (lib.util.mkLspCodeAction [
          {
            key = "<leader>co";
            action = "source.organizeImports";
            desc = "Organize Imports";
          }
        ])
      ];

      binds.whichKey.register."<leader>c" = "+Code";

      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = false;
        lspkind.enable = true;

        mappings = {
          # Workspace Folders
          addWorkspaceFolder = null;
          codeAction = "<leader>ca";
          # Document
          documentHighlight = null;
          # Formatting
          format = "<leader>cf";
          goToDeclaration = null;
          # LSP Specific Mappings (using fzf-lua instead, see fzf.nix)
          goToDefinition = null;
          goToType = null;
          hover = "K";
          listDocumentSymbols = null;
          listImplementations = null;
          listReferences = null;
          listWorkspaceFolders = null;
          listWorkspaceSymbols = null;
          # Diagnostics
          nextDiagnostic = "]d";
          openDiagnosticFloat = "<leader>cd";
          previousDiagnostic = "[d";
          removeWorkspaceFolder = null;
          # Actions
          renameSymbol = "<leader>cr";
          # Misc
          signatureHelp = null;
          toggleFormatOnSave = "<leader>cF";
        };
      };
    };
  };
}
