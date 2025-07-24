{
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
}
