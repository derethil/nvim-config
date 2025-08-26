{lib, ...}: {
  vim.autocmds = [
    {
      event = ["TextYankPost"];
      desc = "Highlight when yanking (copying) text";
      callback = lib.generators.mkLuaInline ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
  ];
}
