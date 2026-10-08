{
  flake.modules.nvf.languages-luau = {
    lib,
    pkgs,
    ...
  }: {
    vim = {
      lazy.plugins."luau-lsp.nvim" = {
        package = pkgs.vimPlugins.luau-lsp-nvim;
        ft = ["luau"];
        setupModule = "luau-lsp";

        setupOpts = {
          platform.type = "standard";
          sourcemap.enabled = false;
          server.path = lib.getExe pkgs.luau-lsp;
        };
      };

      treesitter = {
        enable = true;
        grammars = [pkgs.vimPlugins.nvim-treesitter.grammarPlugins.luau];
      };

      formatter.conform-nvim.setupOpts.formatters_by_ft.luau = ["stylua"];

      diagnostics = {
        presets.selene.enable = true;
        nvim-lint = {
          enable = true;
          linters_by_ft.luau = ["selene"];
        };
      };

      extraPackages = [
        pkgs.luau-lsp
        pkgs.selene
        pkgs.stylua
      ];
    };
  };
}
