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
    (lib.util.mkLspCodeAction [
      {
        key = "gD";
        clientName = "ts_ls";
        action = lib.generators.mkLuaInline ''
          function()
            local params = vim.lsp.util.make_position_params()
            vim.lsp.buf.execute_command({
              command = "typescript.goToSourceDefinition",
              arguments = { params.textDocument.uri, params.position },
            })
          end
        '';
        desc = "Goto Source Definition";
      }
      # TODO: vtsls only, enable once it's available
      # {
      #   key = "gR";
      #   clientName = "ts_ls";
      #   action = lib.generators.mkLuaInline ''
      #     function()
      #       vim.lsp.buf.execute_command({
      #         command = "typescript.findAllFileReferences",
      #         arguments = { vim.uri_from_bufnr(0) },
      #       })
      #     end
      #   '';
      #   desc = "File References";
      # }
      {
        key = "<leader>cM";
        clientName = "ts_ls";
        action = "source.addMissingImports.ts";
        desc = "Add missing imports";
      }
      {
        key = "<leader>cu";
        clientName = "ts_ls";
        action = "source.removeUnused.ts";
        desc = "Remove unused imports";
      }
      {
        key = "<leader>cD";
        clientName = "ts_ls";
        action = "source.fixAll.ts";
        desc = "Fix all diagnostics";
      }
      {
        key = "<leader>cV";
        clientName = "ts_ls";
        action = lib.generators.mkLuaInline ''
          function()
            vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
          end
        '';
        desc = "Select TS workspace version";
      }
    ])
  ];
}
