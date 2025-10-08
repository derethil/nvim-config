{pkgs, ...}: {
  vim.assistant.copilot = {
    enable = true;
    cmp.enable = false;
    setupOpts = {
      panel.enabled = false;
      suggestion.enabled = false;
    };
  };

  vim.lazy.plugins = {
    "blink-cmp-copilot" = {
      package = pkgs.vimPlugins.blink-cmp-copilot;
    };
  };
}
