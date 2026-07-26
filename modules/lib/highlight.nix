{
  flake.modules.nvf.colorscheme-highlights = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption types mkIf mapAttrsToList concatStringsSep filterAttrs;
    inherit (lib.nvim.lua) toLuaObject;

    cfg = config.vim.colorschemeHighlights;

    mkHlCall = name: hl: let
      props = filterAttrs (_: v: v != null) {inherit (hl) link fg bg bold italic underline undercurl strikethrough reverse;};
    in ''vim.api.nvim_set_hl(0, "${name}", ${toLuaObject props})'';
  in {
    options.vim.colorschemeHighlights = mkOption {
      default = {};
      description = "Highlight groups applied after the colorscheme loads via a ColorScheme autocmd.";

      type = types.attrsOf (types.submodule {
        options = {
          bg = mkOption {
            default = null;
            type = types.nullOr types.str;
          };

          bold = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };

          fg = mkOption {
            default = null;
            type = types.nullOr types.str;
          };

          italic = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };

          link = mkOption {
            default = null;
            type = types.nullOr types.str;
          };

          reverse = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };

          strikethrough = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };

          undercurl = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };

          underline = mkOption {
            default = null;
            type = types.nullOr types.bool;
          };
        };
      });
    };

    config = mkIf (cfg != {}) {
      vim.autocmds = [
        {
          event = ["ColorScheme"];

          callback = lib.generators.mkLuaInline ''
            function()
              ${concatStringsSep "\n              " (mapAttrsToList mkHlCall cfg)}
            end
          '';

          desc = "Apply colorscheme-dependent highlight overrides";
        }
      ];
    };
  };
}
