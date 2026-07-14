{...}: {
  flake.modules.nvf.languages-golang-lsp = {lib, ...}: {
    vim.lsp.servers = {
      gopls = {
        init_options.semanticTokens = true;
        settings.gopls = {
          semanticTokens = true;
          gofumpt = true;
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };
          analyses = {
            nilness = true;
            unusedparams = true;
            unusedwrite = true;
            useany = true;
          };
          usePlaceholders = true;
          completeUnimported = true;
          staticcheck = true;
          directoryFilters = ["-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules"];
        };
      };

      golangci_lint_ls = {
        filetypes = ["go"];
        rootPatterns = [".golangci.yml" ".golangci.toml"];
      };
    };

    vim.colorschemeHighlights."@lsp.typemod.string.format.go" = {
      link = "@string.special";
    };

    vim.autocmds = [
      {
        event = ["LspAttach"];
        pattern = ["*.go"];
        desc = "Workaround for gopls not advertising semanticTokensProvider";
        callback =
          lib.generators.mkLuaInline
          /*
          lua
          */
          ''
            function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
                local semantic = vim.lsp.protocol.make_client_capabilities().textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
                vim.lsp.semantic_tokens.start(args.buf, args.data.client_id)
              end
            end
          '';
      }
    ];
  };
}
