{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  vim.lsp.servers = {
    templ = {
      cmd = [(getExe pkgs.templ) "lsp"];
      filetypes = ["templ"];
    };
  };

  vim.treesitter.grammars = [
    pkgs.vimPlugins.nvim-treesitter.builtGrammars.templ
  ];

  # TODO: Enable HTML LSP for templ files when v0.8 is released
  # vim.lsp.servers.superhtml.filetypes = ["templ"];
}
