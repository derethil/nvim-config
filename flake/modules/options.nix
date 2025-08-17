{
  lib,
  inputs,
  pkgs,
}: let
  inherit (lib) mkEnableOption mkOption types literalExpression;
in {
  options.programs.nvim-config = {
    enable = mkEnableOption "My custom Neovim configuration";

    claude = {
      enable = mkEnableOption "Enable Claude Code integration";
      package = mkOption {
        type = types.package;
        default = pkgs.claude-code;
        description = "Nvim plugin package for Claude Code integration";
      };
    };

    sonarlint = {
      enable = mkEnableOption "Enable SonarLint integration";

      languageServerPackage = mkOption {
        type = types.package;
        default = pkgs.sonarlint-ls;
        description = "Package for SonarLint language server";
      };

      connectedMode = {
        enable = mkEnableOption "Enable SonarLint connected mode";

        tokenFile = mkOption {
          type = types.path;
          default = "";
          description = "Path to the file containing the SonarQube token";
        };

        sonarqubeConnections = mkOption {
          type = types.listOf types.attrs;
          default = [];
          description = "List of SonarQube connections for SonarLint";
          example = literalExpression ''
            [
              {
                connectionId = "company";
                serverUrl = "https://sonarqube.company.com";
                disableNotifications = false;
              }
            ]
          '';
        };

        projects = mkOption {
          type = types.attrsOf (types.submodule {
            options = {
              connectionId = mkOption {
                type = types.str;
                description = "Connection ID to use for this project";
              };
              projectKey = mkOption {
                type = types.str;
                description = "SonarQube project key";
              };
            };
          });
          default = {};
          description = "Map of project paths to their SonarLint configuration";
          example = literalExpression ''
            {
              "/path/to/project1" = {
                connectionId = "company";
                projectKey = "project1-sonarqube-key";
              };
              "/path/to/project2" = {
                connectionId = "local-sonar";
                projectKey = "project2-key";
              };
            }
          '';
        };
      };
    };

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = "Use Neovim as the default editor.";
    };

    extraSettings = mkOption {
      type = types.attrs;
      default = {};
      description = "Attribute set of nvf preferences";
      example = literalExpression ''
        {
          vim.viAlias = false;
          vim.lsp = {
            enable = true;
            formatOnSave = true;
          };
        }
      '';
    };
  };
}
