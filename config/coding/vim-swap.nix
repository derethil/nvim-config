{pkgs, ...}: {
  vim.lazy.plugins.vim-swap = {
    package = pkgs.vimPlugins.vim-swap;
    lazy = true;
    keys = [
      {
        key = "<leader>c<";
        mode = ["n"];
        action = "<Plug>(swap-prev)";
        desc = "Swap with Prev";
      }
      {
        key = "<leader>c>";
        mode = ["n"];
        action = "<Plug>(swap-next)";
        desc = "Swap with Next";
      }
      {
        key = "<leader>ci";
        mode = ["n"];
        action = "<Plug>(swap-interactive)";
        desc = "Interactive Swap";
      }
    ];
  };
}
