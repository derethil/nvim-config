{pkgs, ...}: {
  vim.theme.enable = false;

  vim.globals = {
    gruvbox_material_transparent_background = 2;
    gruvbox_material_foreground = "material";
    gruvbox_material_background = "medium";
    gruvbox_material_enable_italic = 1;
    gruvbox_material_enable_bold = 1;
    gruvbox_material_ui_contrast = "high";
    gruvbox_material_diagnostic_virtual_text = "colored";
    gruvbox_material_current_word = "underline";
  };

  vim.extraPlugins = {
    gruvbox-material = {
      package = pkgs.vimPlugins.gruvbox-material;
      setup = ''
        local function get_palette()
          local config = vim.fn["gruvbox_material#get_configuration"]()
          local palette = vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
          return palette
        end

        local function customize_gruvbox()
          local palette = get_palette()
          local set_hl = vim.fn["gruvbox_material#highlight"]

          set_hl("MiniFilesNormal", palette.fg1, palette.none)
          set_hl("FloatBorder", palette.grey1, palette.none)
          set_hl("MiniFilesCursorLine", palette.none, palette.bg_diff_green, "bold")
          set_hl("NvimSeparator", palette.green, palette.none)
          set_hl("GitConflictCurrent", palette.none, palette.bg_diff_blue)
          set_hl("GitConflictCurrentLabel", palette.blue, palette.bg_visual_blue, "bold")
          set_hl("GitConflictIncomingLabel", palette.green, palette.bg_visual_green, "bold")

          -- Make sidebars use same background as main windows
          set_hl("NormalFloat", palette.fg1, palette.bg0)
        end

        -- Create autocmd for custom highlights
        vim.api.nvim_create_autocmd("ColorScheme", {
          group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
          pattern = "gruvbox-material",
          callback = customize_gruvbox,
        })

        -- Set colorscheme
        vim.cmd.colorscheme("gruvbox-material")
      '';
    };
  };
}
