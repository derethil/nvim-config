{
  flake.modules.nvf.assistant-copilot = {pkgs, ...}: {
    vim = {
      lazy.plugins."blink-cmp-copilot".package = pkgs.vimPlugins.blink-cmp-copilot;

      assistant.copilot = {
        enable = true;

        setupOpts = {
          panel.enabled = false;
          suggestion.enabled = false;
        };

        cmp.enable = false;
      };

      extraPackages = with pkgs; [
        copilot-language-server
      ];
    };
  };
}
