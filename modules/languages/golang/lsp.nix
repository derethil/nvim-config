{
  flake.modules.nvf.languages-golang-lsp = {lib, ...}: {
    vim = {
      autocmds = [
        {
          event = ["LspAttach"];

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

          pattern = ["*.go"];
          desc = "Workaround for gopls not advertising semanticTokensProvider";
        }
      ];

      colorschemeHighlights = {
        "@lsp.type.string.go" = {};
        "@lsp.typemod.string.format.go".link = "@string.special";
        "@markup.normal".link = "Normal";
      };

      lsp.servers = {
        golangci_lint_ls = {
          filetypes = ["go"];
          rootPatterns = [".golangci.yml" ".golangci.toml"];
        };

        gopls = {
          init_options.semanticTokens = true;

          settings.gopls = {
            analyses = {
              nilness = true;
              unusedparams = true;
              unusedwrite = true;
              useany = true;
            };

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

            completeUnimported = true;
            directoryFilters = ["-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules"];
            gofumpt = true;
            semanticTokens = true;
            staticcheck = true;
            usePlaceholders = true;
          };
        };
      };
    };
  };
}
