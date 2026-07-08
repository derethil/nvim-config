{...}: {
  flake.modules.nvf.languages-css = {
    vim.languages.css = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      format = {
        enable = true;
        type = ["biome"];
      };
    };

    vim.lsp.presets.tailwindcss-language-server = {
      enable = true;
    };
  };
}
