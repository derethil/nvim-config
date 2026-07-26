{
  flake.modules.nvf.languages-markdown = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      languages.markdown = {
        enable = true;
        extensions.markview-nvim.enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      keymaps = [
        (mkKeymap "n" "<leader>cp" "<CMD>MarkdownPreviewToggle<CR>" {desc = "Toggle Markdown Preview";})
      ];

      utility.preview.markdownPreview.enable = true;
    };
  };
}
