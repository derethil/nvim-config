{...}: {
  flake.modules.nvf.ui-breadcrumbs = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (lib.generators) mkLuaInline;
    inherit (lib.whichkey) mkEntry;
  in {
    vim.startPlugins = [
      pkgs.internal.lualine-pretty-path
    ];

    vim.luaConfigRC.whichkey-outline = lib.nvim.dag.entryAnywhere (mkEntry {
      key = "<leader>o";
      desc = "Open Outline";
      icon = "󱒖";
      color = "cyan";
    });

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

    # TODO: open a PR to allow nvim-navic setupOpts
    vim.luaConfigRC.navic-extra = lib.nvim.dag.entryAfter ["breadcrumbs"] ''
      require("nvim-navic").setup { depth_limit = 5 }
    '';

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
  };
}
