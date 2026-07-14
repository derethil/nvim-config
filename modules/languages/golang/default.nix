{...}: {
  flake.modules.nvf.languages-golang = {pkgs, ...}: {
    vim.languages.go = {
      dap.enable = true;
      enable = true;
      lsp.enable = true;
      extraDiagnostics.enable = true;
      treesitter.enable = true;
      format.enable = true;
      extensions.gopher-nvim.enable = true;
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
      file.".go-version" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
      filetype.gotmpl = {
        glyph = "󰟓";
        hl = "MiniIconsGrey";
      };
    };
  };
}
