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
