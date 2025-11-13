{lib, ...}: {
  vim.utility.diffview-nvim = {
    enable = true;
    setupOpts = {
      view = {
        layout = "diff2_horizontal";
        winbar_info = true;
      };
      merge_tool = {
        layout = "diff3_mixed";
        winbar_info = true;
      };
      file_panel = {
        win_config.position = "right";
      };
      keymaps = let
        mkDiffviewKeymap = mode: key: action: desc: [
          mode
          key
          (
            if lib.hasPrefix "<CMD>" action
            then action
            else (lib.generators.mkLuaInline action)
          )
          {
            inherit desc;
            silent = true;
            buffer = true;
          }
        ];
      in {
        view = [
          (mkDiffviewKeymap "n" "q" "<CMD>DiffviewClose<CR>" "Diffview: Quit")

          (mkDiffviewKeymap "n" "[F" ''require("diffview.actions").select_first_entry'' "First File")
          (mkDiffviewKeymap "n" "]F" ''require("diffview.actions").select_last_entry'' "Last File")
          (mkDiffviewKeymap "n" "[f" ''require("diffview.actions").select_prev_entry'' "Previous File")
          (mkDiffviewKeymap "n" "]f" ''require("diffview.actions").select_next_entry'' "Next File")

          (mkDiffviewKeymap "n" "[m" ''require("diffview.actions").prev_conflict'' "Previous Conflict")
          (mkDiffviewKeymap "n" "]m" ''require("diffview.actions").next_conflict'' "Next Conflict")

          (mkDiffviewKeymap "n" "<leader>mo" ''require("diffview.actions").conflict_choose("ours")'' "Choose OURS")
          (mkDiffviewKeymap "n" "<leader>mt" ''require("diffview.actions").conflict_choose("theirs")'' "Choose THEIRS")
          (mkDiffviewKeymap "n" "<leader>mb" ''require("diffview.actions").conflict_choose("base")'' "Choose BASE")
          (mkDiffviewKeymap "n" "<leader>ma" ''require("diffview.actions").conflict_choose("all")'' "Choose ALL")
          (mkDiffviewKeymap "n" "<leader>mx" ''require("diffview.actions").conflict_choose("none")'' "Delete conflict region")

          (mkDiffviewKeymap "n" "<leader>mO" ''require("diffview.actions").conflict_choose_all("ours")'' "Choose OURS (whole file)")
          (mkDiffviewKeymap "n" "<leader>mT" ''require("diffview.actions").conflict_choose_all("theirs")'' "Choose THEIRS (whole file)")
          (mkDiffviewKeymap "n" "<leader>mB" ''require("diffview.actions").conflict_choose_all("base")'' "Choose BASE (whole file)")
          (mkDiffviewKeymap "n" "<leader>mA" ''require("diffview.actions").conflict_choose_all("all")'' "Choose ALL (whole file)")
          (mkDiffviewKeymap "n" "<leader>mX" ''require("diffview.actions").conflict_choose_all("none")'' "Delete conflict region (whole file)")
        ];
        file_panel = [
          (mkDiffviewKeymap "n" "q" "<CMD>DiffviewClose<CR>" "Diffview: Quit")
        ];
      };
    };
  };
}
