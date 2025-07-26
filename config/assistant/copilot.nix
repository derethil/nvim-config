{pkgs, ...}: {
  vim.assistant.copilot = {
    enable = false;
    cmp.enable = true;
  };

  vim.lazy.plugins = {
    "blink-cmp-copilot" = {
      package = pkgs.vimPlugins.blink-cmp-copilot;
    };
  };
}
