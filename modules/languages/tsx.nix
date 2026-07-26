{
  flake.modules.nvf.languages-tsx = {
    vim.languages.tsx = {
      enable = true;
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
  };
}
