{...}: {
  flake.modules.nvf.colorscheme-highlights = {
    lib,
    config,
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
      type = types.attrsOf (types.submodule {
        options = {
          link = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          fg = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          bg = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
          bold = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
          italic = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
          underline = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
          undercurl = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
          strikethrough = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
          reverse = mkOption {
            type = types.nullOr types.bool;
            default = null;
          };
        };
      });
      default = {};
      description = "Highlight groups applied after the colorscheme loads via a ColorScheme autocmd.";
    };

    config = mkIf (cfg != {}) {
      vim.autocmds = [
        {
          event = ["ColorScheme"];
          desc = "Apply colorscheme-dependent highlight overrides";
          callback = lib.generators.mkLuaInline ''
            function()
              ${concatStringsSep "\n              " (mapAttrsToList mkHlCall cfg)}
            end
          '';
        }
      ];
    };
  };
}
