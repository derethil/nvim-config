{
  pkgs,
  lib,
  ...
}: let
  filetypes = ["javascript" "typescript" "javascriptreact" "typescriptreact" "go"];

  analyzers = ["sonarjs" "sonarpython" "sonarhtml" "sonargo" "sonartext"];
  analyzerPaths = map (analyzer: "${pkgs.sonarlint-ls}/share/plugins/${analyzer}.jar") analyzers;

  cmd = lib.flatten [
    "${pkgs.sonarlint-ls}/bin/sonarlint-ls"
    "-stdio"
    "-analyzers"
    analyzerPaths
  ];
in {
  vim.extraPackages = with pkgs; [
    sonarlint-ls
  ];

  vim.lazy.plugins.sonarlint-nvim = {
    # TODO: update package when connected mode is merged: https://gitlab.com/schrieveslaach/sonarlint.nvim
    package = pkgs.internal.sonarlint-nvim;
    before = ''
      local lspconfig = require("lspconfig")
    '';
    enabled = ''
      function()
        local current_dir = vim.fn.getcwd()
        return vim.startswith(current_dir, vim.fn.expand("~/development/dragonarmy/"))
      end
    '';
    ft = filetypes;
    setupModule = "sonarlint";
    setupOpts = {
      filetypes = filetypes;
      connected.get_credentials = ''
        function()
          return vim.fn.getenv("SONAR_TOKEN")
        end
      '';
      server = {
        cmd = cmd;
        sonarlint.connectedMode = {
          project = {
            connectionId = "dragonarmy";
            projectKey = ''vim.fn.getenv("SONAR_PROJECT_KEY") or ""'';
          };
          connections.sonarqube = [
            {
              connectionId = "dragonarmy";
              serverUrl = "https://sonarqube.dragonarmy.com";
              disableNotifications = false;
            }
          ];
        };
      };
    };
  };
}
