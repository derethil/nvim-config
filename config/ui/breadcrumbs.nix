{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.generators) mkLuaInline;
in {
  vim.startPlugins = [
    pkgs.internal.lualine-pretty-path
  ];

  vim.keymaps = [
    (mkKeymap "n" "<leader>o" "<CMD>Navbuddy<CR>" {
      desc = "Open Outline";
      silent = true;
    })
  ];

  vim.ui.breadcrumbs = {
    enable = true;
    source = "nvim-navic";

    lualine.winbar = {
      enable = false;
      alwaysRender = true;
    };

    navbuddy = {
      enable = true;
      mappings = {
        vsplit = "|";
        hsplit = "-";
      };
    };
  };

  vim.statusline.lualine.setupOpts = let
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
    winbar = {
      lualine_c = [
        (mkLuaInline prettyPath)
        (mkLuaInline ''"navic"'')
      ];
    };
    inactive_winbar = {
      lualine_c = [
        (mkLuaInline prettyPath)
      ];
    };
  };
}
