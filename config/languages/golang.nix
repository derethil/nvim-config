{pkgs, ...}: {
  vim.languages.go = {
    dap.enable = false;
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
    };
  };

  vim.lsp.servers = {
    golangci_lint_ls = {
      filetypes = ["go"];
      rootPatterns = [".golangci.yml" ".golangci.toml"];
    };
  };

  vim.extraPackages = with pkgs; [
    golangci-lint
    golangci-lint-langserver

    # packages for gopher-nvim
    gomodifytags
    impl
    gotests
    iferr
    internal.json2go
  ];

  vim.mini.icons.setupOpts = {
    file = {
      ".go-version" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
    };
    filetype = {
      gotmpl = {
        glyph = "󰟓";
        hl = "MiniIconsGrey";
      };
    };
  };

  vim.lazy.plugins.gopher-nvim = {
    package = pkgs.internal.gopher-nvim;
    setupModule = "gopher";
    setupOpts = {};
    ft = ["go" "gomod" "gotmpl"];
  };
}
