{
  pkgs,
  lib,
  module ? {},
  ...
}: let
  cfg = module.config.sonarlint or {};

  filetypes = ["javascript" "typescript" "javascriptreact" "typescriptreact" "go"];

  analyzers = ["sonarjs" "sonarpython" "sonarhtml" "sonargo" "sonartext"];
  analyzerPaths = map (analyzer: "${cfg.languageServerPackage or pkgs.sonarlint-ls}/share/plugins/${analyzer}.jar") analyzers;

  cmd = lib.flatten [
    "${cfg.languageServerPackage or pkgs.sonarlint-ls}/bin/sonarlint-ls"
    "-stdio"
    "-analyzers"
    analyzerPaths
  ];
in {
  config = lib.mkIf (cfg.enable or false) {
    vim.extraPackages = [
      cfg.languageServerPackage or pkgs.sonarlint-ls
    ];

    vim.lazy.plugins."sonarlint.nvim" = {
      package = pkgs.vimPlugins.sonarlint-nvim;
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
        connected = lib.mkIf (cfg.connectedMode.enable or false) {
          get_credentials = lib.generators.mkLuaInline ''
            function()
              local token_file = "${cfg.connectedMode.tokenFile}"
              local file = io.open(token_file, "r")
              if file then
                local token = file:read("*line")
                file:close()
                return token
              end
              return nil
            end
          '';
        };
        server = {
          cmd = cmd;
          before_init =
            lib.mkIf (cfg.connectedMode.enable or false)
            (lib.generators.mkLuaInline
              ''
                function(params, config)
                  local projects = ${lib.generators.toLua {} cfg.connectedMode.projects}
                  local project = projects[params.rootPath]

                  if project then
                    config.settings.sonarlint.connectedMode.project = {
                      connectionId = project.connectionId,
                      projectKey = project.projectKey,
                    }
                  end
                end
              '');
          settings.sonarlint.connectedMode = lib.mkIf (cfg.connectedMode.enable or false) {
            connections.sonarqube = cfg.connectedMode.sonarqubeConnections;
          };
        };
      };
    };
  };
}
