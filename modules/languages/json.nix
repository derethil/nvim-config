{
  flake.modules.nvf.languages-json = {lib, ...}: {
    vim.languages.json = {
      enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };

    vim.autocmds = [
      {
        event = ["FileType"];
        pattern = ["json" "jsonc"];

        callback = lib.generators.mkLuaInline ''
          function()
            vim.wo.conceallevel = 0
          end
        '';

        desc = "Disable treesitter conceal of quotes in JSON";
      }
    ];
  };
}
