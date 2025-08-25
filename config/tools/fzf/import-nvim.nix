{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.lazy.plugins.import-nvim = {
    package = pkgs.internal.import-nvim;
    setupModule = "import";
    setupOpts = {
      picker = "fzf-lua";
      custom_languages = [
        {
          extensions = ["nix"];
          filetypes = ["nix"];
          regex = lib.generators.mkLuaInline ''[[^\s*inherit\s+\(?([^);]+)\)?]]'';
          insert_at_line = lib.generators.mkLuaInline ''
            function()
              return vim.fn.search("let", "n") + 1
            end
          '';
        }
      ];
    };
    priority = 10; # load after fzf-lua
    keys = [
      (mkKeymap "n" "<leader>si" "<CMD>Import<CR>" {desc = "Search Imports";})
    ];
  };
}
