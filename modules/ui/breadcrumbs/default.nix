{
  flake.modules.nvf.ui-breadcrumbs = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (lib.generators) mkLuaInline;
    inherit (lib.whichkey) mkEntry;
  in {
    vim = {
      keymaps = [
        (mkKeymap "n" "<leader>o" "<CMD>Navbuddy<CR>" {
          silent = true;
          desc = "Open Outline";
        })
      ];

      luaConfigRC = {
        # TODO: open a PR to allow nvim-navic setupOpts
        navic-extra = lib.nvim.dag.entryAfter ["breadcrumbs"] ''
          require("nvim-navic").setup { depth_limit = 5 }
        '';

        whichkey-outline = lib.nvim.dag.entryAnywhere (mkEntry {
          key = "<leader>o";
          color = "cyan";
          icon = "󱒖";
          desc = "Open Outline";
        });
      };

      startPlugins = [
        pkgs.internal.lualine-pretty-path
      ];

      statusline.lualine.setupOpts = let
        prettyPath = ''
          {
            "pretty_path",
            directories = { max_depth = 3 },

            separator = ">",
            path_sep = " > ",
            icon_show = true,
            icon_show_inactive = true
          }
        '';
      in {
        inactive_winbar.lualine_c = [
          (mkLuaInline prettyPath)
        ];

        winbar.lualine_c = [
          (mkLuaInline prettyPath)
          (mkLuaInline ''"navic"'')
        ];
      };

      ui.breadcrumbs = {
        enable = true;

        lualine.winbar = {
          enable = false;
          alwaysRender = true;
        };

        navbuddy = {
          enable = true;

          mappings = {
            hsplit = "-";
            vsplit = "|";
          };
        };

        source = "nvim-navic";
      };
    };
  };
}
