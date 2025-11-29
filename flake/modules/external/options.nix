{
  lib,
  inputs,
  pkgs,
}: let
  inherit (lib) mkEnableOption mkOption types literalExpression;
in {
  options.programs.nvim-config = {
    enable = mkEnableOption "My custom Neovim configuration";

    neovim = {
      nightly = mkOption {
        type = types.bool;
        default = false;
        description = "Use neovim nightly package instead of stable";
      };

      package = mkOption {
        type = types.nullOr types.package;
        default = null;
        description = "Custom neovim package to use. Overrides useNightly when set.";
        example = literalExpression "pkgs.neovim-unwrapped";
      };

      defaultEditor = mkOption {
        type = types.bool;
        default = false;
        description = "Use Neovim as the default editor.";
      };
    };

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

      connectedMode = {
        enable = mkEnableOption "Enable SonarLint connected mode";

        connections.sonarqube = mkOption {
          type = types.listOf types.attrs;
          default = [];
          description = "List of SonarQube connections for SonarLint connected mode";
          example = literalExpression ''
            [
              {
                connectionId = "an_arbitrary_connection_id";
                serverUrl = "https://sonarqube.example.com";
                disableNotifications = false;
              }
            ]
          '';
        };

        projects = mkOption {
          default = {};
          description = "Project configuration for SonarLint connected mode";
          type = types.attrsOf (
            types.submodule {
              options = {
                connectionId = mkOption {
                  type = types.str;
                  description = "The connection ID to use for this project";
                };
                projectKey = mkOption {
                  type = types.str;
                  description = "The project key in SonarQube";
                };
              };
            }
          );
          example = literalExpression ''
            path_to_project = {
              connectionId = "my_connection";
              projectKey = "my_project_key";
            };
          '';
        };
      };
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
