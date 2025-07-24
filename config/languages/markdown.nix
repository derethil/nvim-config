{
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
    {
      key = "<leader>cp";
      mode = ["n"];
      action = "<CMD>MarkdownPreviewToggle<CR>";
      desc = "Toggle Markdown Preview";
    }
  ];
}
