{
  flake.modules.nvf.languages-css = {
    vim = {
      languages.css = {
        enable = true;

        format = {
          enable = true;
          type = ["biome"];
        };

        lsp.enable = true;
        treesitter.enable = true;
      };

      lsp.presets.tailwindcss-language-server.enable = true;
    };
  };
}
