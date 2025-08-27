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
      pkgs.nodejs_24 # required for some reason
    ];

    vim.lazy.plugins."sonarlint.nvim" = {
      package = pkgs.vimPlugins.sonarlint-nvim;
      before = ''
        local lspconfig = require("lspconfig")
      '';
      # enabled = lib.mkIf (cfg.connectedMode.enable or false) ''
      #   function()
      #     print("checking SonarLint for current_dir:")
      #
      #     local current_dir = vim.fn.getcwd()
      #     local projects = ${lib.generators.toLua {} cfg.connectedMode.projects}
      #
      #     -- Check if current directory is within any configured project
      #     for project_path, _ in pairs(projects) do
      #       -- Expand ~ to home directory
      #       local expanded_path = vim.fn.expand(project_path)
      #       -- Check if current_dir starts with the project path
      #       if vim.startswith(current_dir, expanded_path) then
      #         return true
      #       end
      #     end
      #
      #     return false
      #   end
      # '';
      ft = filetypes;
      setupModule = "sonarlint";
      setupOpts = {
        filetypes = filetypes;
        connected = lib.mkIf (cfg.connectedMode.enable or false) {
          get_credentials = lib.generators.mkLuaInline ''
            function()
              -- Check for project-specific tokenFile
              local current_dir = vim.fn.getcwd()
              local projects = ${lib.generators.toLua {} cfg.connectedMode.projects}
              local project = projects[current_dir]

              if project and project.tokenFile then
                local file = io.open(project.tokenFile, "r")
                if file then
                  local token = file:read("*all"):gsub("%s+", "")
                  file:close()
                  return token
                end
              end

              -- Fallback to environment variable
              return vim.fn.getenv("SONAR_TOKEN")
            end
          '';
        };
        server = {
          cmd = cmd;
          before_init = lib.mkIf (cfg.connectedMode.enable or false) (lib.generators.mkLuaInline ''
            function(params, config)
              local projects = ${lib.generators.toLua {} cfg.connectedMode.projects}
              local project = projects[params.rootPath]

              config.settings.sonarlint.connectedMode.project = {
                connectionId = project.connectionId,
                projectKey = project.projectKey,
              }
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
