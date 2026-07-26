{
  flake.modules.nvf.languages-templ = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) getExe;
  in {
    vim = {
      lsp.servers = {
        superhtml.filetypes = ["templ"];

        templ = {
          cmd = [(getExe pkgs.templ) "lsp"];
          filetypes = ["templ"];
        };
      };

      treesitter.grammars = [
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.templ
      ];
    };
  };
}
