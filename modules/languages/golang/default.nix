{
  flake.modules.nvf.languages-golang = {pkgs, ...}: {
    vim = {
      languages.go = {
        enable = true;
        dap.enable = true;
        extensions.gopher-nvim.enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      extraPackages = with pkgs; [
        golangci-lint
        golangci-lint-langserver

        # packages for gopher-nvim
        gomodifytags
        impl
        gotests
        iferr
        internal.json2go
      ];

      mini.icons.setupOpts = {
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
  };
}
