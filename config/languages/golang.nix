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
}
