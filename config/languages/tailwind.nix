{pkgs, ...}: {
  vim.languages.tailwind = {
    enable = true;
    lsp.enable = false;
  };

  vim.extraPackages = [
    pkgs.tailwindcss-language-server
  ];

  vim.lsp.servers.tailwindcss = {
    enable = true;
    filetypes = [
      "html"
      "css"
      "scss"
      "javascript"
      "javascriptreact"
      "typescript"
      "typescriptreact"
      "svelte"
    ];
    settings = {
      tailwindCSS = {
        lint = {
          cssConflict = "warning";
          invalidApply = "error";
          invalidConfigPath = "error";
          invalidScreen = "error";
          invalidTailwindDirective = "error";
          invalidVariant = "error";
          recommendedVariantOrder = "warning";
        };
        experimental = {
          classRegex = [
            ["([\"'`][^\"'`]*.*?[\"'`])" "[\"'`]([^\"'`]*).*?[\"'`]"] # Tailwind Variants
          ];
        };
      };
    };
  };
}
