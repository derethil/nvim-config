{lib, ...}: {
  vim.diagnostics = {
    enable = true;
    config = {
      update_in_insert = true;
      underline = true;
      virtual_text = true;
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
