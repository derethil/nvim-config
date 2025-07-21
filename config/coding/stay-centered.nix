{pkgs, ...}: {
  vim.lazy.plugins."stay-centered.nvim" = {
    package = pkgs.vimPlugins.stay-centered-nvim;
    event = [
      {
        event = "User";
        pattern = "LazyFile";
      }
    ];
    setupModule = "stay-centered";
    setupOpts = {
      allow_scroll_move = false; # workaround for https://github.com/arnamak/stay-centered.nvim/issues/23
    };
  };
}
