{
  lib,
  inputs,
  pkgs,
}: let
  inherit (lib) mkEnableOption mkOption types literalExpression;
  nvfModule = inputs.nvf.lib.nvfTypes.createModuleSystem pkgs;
in {
  options.programs.nvim-config = {
    enable = mkEnableOption "My custom Neovim configuration";

    claude.enable = mkEnableOption "Enable Claude Code integration";

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = "Use Neovim as the default editor.";
    };

    settings = mkOption {
      type = nvfModule;
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

