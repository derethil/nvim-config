{
  flake.modules.nvf.lsp-diagnostics = {lib, ...}: {
    vim.diagnostics = {
      config = {
        float = {
          close_events = ["CursorMoved" "BufHidden" "LspDetach"];
          focusable = true;
        };

        severity_sort = true;

        signs.text = lib.generators.mkLuaInline ''
          {
            [vim.diagnostic.severity.ERROR] = "${lib.icons.diagnostics.Error}",
            [vim.diagnostic.severity.WARN] = "${lib.icons.diagnostics.Warn}",
            [vim.diagnostic.severity.HINT] = "${lib.icons.diagnostics.Hint}",
            [vim.diagnostic.severity.INFO] = "${lib.icons.diagnostics.Info}",
          }
        '';

        underline = true;
        update_in_insert = true;

        virtual_text.format = lib.generators.mkLuaInline ''
          function(diagnostic)
            return string.format("%s [%s]", diagnostic.message, diagnostic.source)
          end
        '';
      };

      enable = true;
    };
  };
}
