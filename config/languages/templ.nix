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

  vim.lsp.servers.superhtml.filetypes = ["templ"];
}
