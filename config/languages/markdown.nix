{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.languages.markdown = {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
    };
    extensions = {
      render-markdown-nvim.enable = true;
    };
    extraDiagnostics.enable = true;
  };

  vim.utility.preview.markdownPreview = {
    enable = true;
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>cp" "<CMD>MarkdownPreviewToggle<CR>" {desc = "Toggle Markdown Preview";})
  ];
}
