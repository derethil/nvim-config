{
  # Declares the `vim.usercmds` option consumed by ./usercmds.nix. Lives in
  # its own flake-parts module (and uses an underscore-prefixed name to sort
  # before consumers in nvf module merge order, though merge order shouldn't
  # actually matter here).
  flake.modules.nvf.usercmds-option = {
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

        addr = mkOption {
          default = null;
          description = ''Address type for range. Can be "lines", "arguments", "buffers", etc.'';
          example = "lines";
          type = nullOr str;
        };

        bang = mkOption {
          default = false;
          description = "Whether the command can be called with a bang (!).";
          type = bool;
        };

        bar = mkOption {
          default = false;
          description = "Whether the command can be followed by another command using |.";
          type = bool;
        };

        command = mkOption {
          default = null;
          description = "Command to be executed when the user command is invoked.";

          example = literalExpression ''
            mkLuaInline '''
              function(opts)
                  vim.lsp.buf.format({ async = true })
              end
            ''''
          '';

          type = nullOr (either str luaInline);
        };

        complete = mkOption {
          default = null;

          description = ''
            Command completion. Can be:
            - Built-in completion types: "file", "buffer", "command", "function", etc.
            - Lua function for custom completion
          '';

          example = "file";
          type = nullOr (either str luaInline);
        };

        count = mkOption {
          default = null;
          description = "Default count for the command.";
          example = 1;
          type = nullOr int;
        };

        force = mkOption {
          default = false;
          description = "Whether to replace an existing command with the same name.";
          type = bool;
        };

        name = mkOption {
          description = "The name of the user command.";
          example = "FormatBuffer";
          type = str;
        };

        nargs = mkOption {
          default = null;

          description = ''
            Number of arguments the command accepts:
            - "0": no arguments (default)
            - "1": exactly one argument
            - "*": any number of arguments
            - "?": 0 or 1 arguments
            - "+": 1 or more arguments
          '';

          example = "*";
          type = nullOr str;
        };

        preview = mkOption {
          default = null;
          description = "Lua function for command preview functionality.";
          type = nullOr luaInline;
        };

        range = mkOption {
          default = null;

          description = ''
            Range specification:
            - true: range allowed, default is current line
            - "%": range allowed, default is whole file
            - number: range allowed, default is that count
          '';

          example = true;
          type = nullOr (oneOf [bool str int]);
        };

        desc = mkOption {
          default = null;
          description = "A description for the user command.";
          example = "Format the current buffer using LSP";
          type = nullOr str;
        };
      };
    };

    cfg = config.vim;
  in {
    options.vim.usercmds = mkOption {
      default = [];

      description = ''
        A list of Neovim user commands to be registered.

        Each entry defines a user command, specifying the command name, a callback or Vim
        command, description, argument handling, and other command attributes.
      '';

      type = listOf usercommandType;
    };

    config = {
      vim = let
        enabledUsercommands = filter (cmd: cmd.enable) cfg.usercmds;
      in {
        luaConfigRC.usercmds = entryAfter ["pluginConfigs"] (optionalString (enabledUsercommands != []) ''
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
  };
}
