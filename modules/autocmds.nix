{
  flake.modules.nvf.autocmds = {lib, ...}: {
    vim.autocmds = [
      {
        event = ["TextYankPost"];

        callback = lib.generators.mkLuaInline ''
          function()
            vim.hl.on_yank()
          end
        '';

        desc = "Highlight when yanking (copying) text";
      }
    ];
  };
}
