{
  pkgs,
  lib,
  ...
}: {
  vim.languages.ts = {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    extraDiagnostics.enable = true;
    format = {
      enable = true;
      type = "prettierd";
    };
    extensions = {
      ts-error-translator.enable = true;
    };
  };

  vim.mini.icons.setupOpts = {
    file = {
      ".eslintrc.js" = {
        glyph = "󰱺";
        hl = "MiniIconsYellow";
      };
      ".node-version" = {
        glyph = "";
        hl = "MiniIconsGreen";
      };
      ".prettierrc" = {
        glyph = "";
        hl = "MiniIconsPurple";
      };
      ".yarnrc.yml" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
      "eslint.config.js" = {
        glyph = "󰱺";
        hl = "MiniIconsYellow";
      };
      "package.json" = {
        glyph = "";
        hl = "MiniIconsGreen";
      };
      "tsconfig.json" = {
        glyph = "";
        hl = "MiniIconsAzure";
      };
      "tsconfig.build.json" = {
        glyph = "";
        hl = "MiniIconsAzure";
      };
      "yarn.lock" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
    };
  };

  vim.extraPackages = [
    pkgs.typescript-language-server
  ];

  vim.autocmds = [
    {
      event = ["LspAttach"];
      desc = "TypeScript LSP Keymaps";
      callback = lib.generators.mkLuaInline ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil or client.name ~= 'ts_ls' then
            return
          end

          local bufnr = args.buf
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Source Definition
          map("n", "gD", function()
            local params = vim.lsp.util.make_position_params()
            vim.lsp.buf.execute_command({
              command = "typescript.goToSourceDefinition",
              arguments = { params.textDocument.uri, params.position },
            })
          end, "Goto Source Definition")

          -- File References
          map("n", "gR", function()
            vim.lsp.buf.execute_command({
              command = "typescript.findAllFileReferences",
              arguments = { vim.uri_from_bufnr(0) },
            })
          end, "File References")

          -- Add missing imports
          map("n", "<leader>cM", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.addMissingImports.ts" } },
              apply = true,
            })
          end, "Add missing imports")

          -- Remove unused imports
          map("n", "<leader>cu", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.removeUnused.ts" } },
              apply = true,
            })
          end, "Remove unused imports")

          -- Fix all diagnostics
          map("n", "<leader>cD", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.fixAll.ts" } },
              apply = true,
            })
          end, "Fix all diagnostics")

          -- Select TypeScript version
          map("n", "<leader>cV", function()
            vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
          end, "Select TS workspace version")
        end
      '';
    }
  ];
}
