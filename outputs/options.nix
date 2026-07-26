{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types literalExpression;
in {
  # Shared `programs.nvim-config` option schema for the NixOS, home-manager,
  # and darwin integration modules. Lives at the flake-parts level so all
  # three integrations can `imports = [ self.lib.integrationOptions ]`.
  flake.lib.integrationOptions = {pkgs}: {
    options.programs.nvim-config = {
      enable = mkEnableOption "My custom Neovim configuration";

      claude = {
        enable = mkEnableOption "Enable Claude Code integration";

        package = mkOption {
          default = pkgs.claude-code;
          description = "Nvim plugin package for Claude Code integration";
          type = types.package;
        };
      };

      extraSettings = mkOption {
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

        type = types.attrs;
      };

      neovim = {
        package = mkOption {
          default = null;
          description = "Custom neovim package to use. Overrides useNightly when set.";
          example = literalExpression "pkgs.neovim-unwrapped";
          type = types.nullOr types.package;
        };

        defaultEditor = mkOption {
          default = false;
          description = "Use Neovim as the default editor.";
          type = types.bool;
        };

        nightly = mkOption {
          default = false;
          description = "Use neovim nightly package instead of stable";
          type = types.bool;
        };
      };

      sonarlint = {
        enable = mkEnableOption "Enable SonarLint integration";

        connectedMode = {
          enable = mkEnableOption "Enable SonarLint connected mode";

          connections.sonarqube = mkOption {
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

            type = types.listOf types.attrs;
          };

          projects = mkOption {
            default = {};
            description = "Project configuration for SonarLint connected mode";

            example = literalExpression ''
              path_to_project = {
                connectionId = "my_connection";
                projectKey = "my_project_key";
              };
            '';

            type = types.attrsOf (
              types.submodule {
                options = {
                  connectionId = mkOption {
                    description = "The connection ID to use for this project";
                    type = types.str;
                  };

                  projectKey = mkOption {
                    description = "The project key in SonarQube";
                    type = types.str;
                  };
                };
              }
            );
          };
        };
      };
    };
  };
}
