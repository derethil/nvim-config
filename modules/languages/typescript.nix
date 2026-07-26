{
  flake.modules.nvf.languages-typescript = {
    lib,
    pkgs,
    ...
  }: {
    vim = {
      languages.typescript = {
        enable = true;
        extensions.ts-error-translator.enable = false;
        extraDiagnostics.enable = true;

        format = {
          enable = true;
          type = ["biome" "biome-organize-imports"];
        };

        lsp = {
          enable = true;
          servers = ["typescript-go"];
        };

        treesitter.enable = true;
      };

      # Typescript Specific Code Actions
      autocmds = [
        (lib.util.mkLspCodeAction [
          {
            key = "gD";

            action = lib.generators.mkLuaInline ''
              function()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.buf.execute_command({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                })
              end
            '';

            clientName = "ts_ls";
            desc = "Goto Source Definition";
          }
          {
            key = "<leader>cM";
            action = "source.addMissingImports.ts";
            clientName = "ts_ls";
            desc = "Add missing imports";
          }
          {
            key = "<leader>cu";
            action = "source.removeUnused.ts";
            clientName = "ts_ls";
            desc = "Remove unused imports";
          }
          {
            key = "<leader>cD";
            action = "source.fixAll.ts";
            clientName = "ts_ls";
            desc = "Fix all diagnostics";
          }
          {
            key = "<leader>cV";

            action = lib.generators.mkLuaInline ''
              function()
                vim.lsp.buf.execute_command({ command = "typescript.selectTypeScriptVersion" })
              end
            '';

            clientName = "ts_ls";
            desc = "Select TS workspace version";
          }
        ])
      ];

      extraPackages = [
        pkgs.eslint_d # keep this installed for projects that use it, even if it's not used globally
      ];

      # Icons
      mini.icons.setupOpts.file = {
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

        "tsconfig.build.json" = {
          glyph = "";
          hl = "MiniIconsAzure";
        };

        "tsconfig.json" = {
          glyph = "";
          hl = "MiniIconsAzure";
        };

        "yarn.lock" = {
          glyph = "";
          hl = "MiniIconsBlue";
        };
      };
    };
  };
}
