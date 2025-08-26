{lib, ...}: {
  vim.diagnostics = {
    enable = true;
    config = {
      update_in_insert = true;
      underline = true;
      virtual_text = {
        format = lib.generators.mkLuaInline ''
          function(diagnostic)
            return string.format("%s [%s]", diagnostic.message, diagnostic.source)
          end
        '';
      };
      signs = {
        text = lib.generators.mkLuaInline ''
          {
            [vim.diagnostic.severity.ERROR] = "${lib.icons.diagnostics.Error}",
            [vim.diagnostic.severity.WARN] = "${lib.icons.diagnostics.Warn}",
            [vim.diagnostic.severity.HINT] = "${lib.icons.diagnostics.Hint}",
            [vim.diagnostic.severity.INFO] = "${lib.icons.diagnostics.Info}",
          }
        '';
      };
    };
  };
}
