{pkgs, ...}:
with pkgs.vimPlugins; {
  vim.lazy.plugins = {
    nvim-navic = {
      package = nvim-navic;
      setupModule = "nvim-navic";
      setupOpts = {};
      event = [
        {
          event = "User";
          pattern = "LazyFile";
        }
      ];
    };
    "barbecue.nvim" = {
      package = barbecue-nvim;
      setupModule = "barbecue";
      event = [
        {
          event = "User";
          pattern = "LazyFile";
        }
      ];
    };
  };
}
