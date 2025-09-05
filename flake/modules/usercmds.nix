{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption literalExpression;
  inherit (lib.lists) filter;
  inherit (lib.strings) optionalString;
  inherit (lib.types) nullOr submodule listOf str bool int oneOf either;
  inherit (lib.nvim.types) luaInline;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryAfter;

  usercommandType = submodule {
    options = {
      enable =
        mkEnableOption ""
        // {
          default = true;
          description = "Whether to enable this user command.";
        };

      name = mkOption {
        type = str;
        example = "FormatBuffer";
        description = "The name of the user command.";
      };

      command = mkOption {
        type = nullOr (either str luaInline);
        default = null;
        example = literalExpression ''
          mkLuaInline '''
            function(opts)
                vim.lsp.buf.format({ async = true })
            end
          ''''
        '';
        description = "Command to be executed when the user command is invoked.";
      };

      desc = mkOption {
        type = nullOr str;
        default = null;
        example = "Format the current buffer using LSP";
        description = "A description for the user command.";
      };

      nargs = mkOption {
        type = nullOr str;
        default = null;
        example = "*";
        description = ''
          Number of arguments the command accepts:
          - "0": no arguments (default)
          - "1": exactly one argument
          - "*": any number of arguments
          - "?": 0 or 1 arguments
          - "+": 1 or more arguments
        '';
      };

      range = mkOption {
        type = nullOr (oneOf [bool str int]);
        default = null;
        example = true;
        description = ''
          Range specification:
          - true: range allowed, default is current line
          - "%": range allowed, default is whole file
          - number: range allowed, default is that count
        '';
      };

      count = mkOption {
        type = nullOr int;
        default = null;
        example = 1;
        description = "Default count for the command.";
      };

      addr = mkOption {
        type = nullOr str;
        default = null;
        example = "lines";
        description = ''Address type for range. Can be "lines", "arguments", "buffers", etc.'';
      };

      bang = mkOption {
        type = bool;
        default = false;
        description = "Whether the command can be called with a bang (!).";
      };

      bar = mkOption {
        type = bool;
        default = false;
        description = "Whether the command can be followed by another command using |.";
      };

      complete = mkOption {
        type = nullOr (either str luaInline);
        default = null;
        example = "file";
        description = ''
          Command completion. Can be:
          - Built-in completion types: "file", "buffer", "command", "function", etc.
          - Lua function for custom completion
        '';
      };

      preview = mkOption {
        type = nullOr luaInline;
        default = null;
        description = "Lua function for command preview functionality.";
      };

      force = mkOption {
        type = bool;
        default = false;
        description = "Whether to replace an existing command with the same name.";
      };
    };
  };

  cfg = config.vim;
in {
  options.vim = {
    usercmds = mkOption {
      type = listOf usercommandType;
      default = [];
      description = ''
        A list of Neovim user commands to be registered.

        Each entry defines a user command, specifying the command name, a callback or Vim
        command, description, argument handling, and other command attributes.
      '';
    };
  };

  config = {
    vim = let
      enabledUsercommands = filter (cmd: cmd.enable) cfg.usercmds;
    in {
      luaConfigRC = {
        usercmds = entryAfter ["pluginConfigs"] (optionalString (enabledUsercommands != []) ''
          local nvf_usercommands = ${toLuaObject enabledUsercommands}
          for _, usercmd in ipairs(nvf_usercommands) do
            vim.api.nvim_create_user_command(
              usercmd.name,
              usercmd.command,
              {
                desc      = usercmd.desc,
                nargs     = usercmd.nargs,
                range     = usercmd.range,
                count     = usercmd.count,
                addr      = usercmd.addr,
                bang      = usercmd.bang,
                bar       = usercmd.bar,
                complete  = usercmd.complete,
                preview   = usercmd.preview,
                force     = usercmd.force
              }
            )
          end
        '');
      };
    };

    assertions = [
      {
        assertion = builtins.all (cmd: cmd.command != null) cfg.usercmds;
        message = "All user commands must have a 'command' defined.";
      }
      {
        assertion = builtins.all (cmd: cmd.name != null && cmd.name != "") cfg.usercmds;
        message = "All user commands must have a non-empty name.";
      }
    ];
  };
}
