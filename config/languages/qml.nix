{pkgs, ...}: {
  vim.extraPackages = with pkgs; [
    kdePackages.qtdeclarative
  ];

  vim.lsp.servers = {
    qmlls = {
      filetypes = ["qml"];
      rootPatterns = [".qmlls.ini"];
    };
  };

  vim.treesitter.grammars = with pkgs; [
    vimPlugins.nvim-treesitter.builtGrammars.qmljs
  ];
}
