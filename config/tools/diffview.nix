{
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
        mkDiffviewKeymap = mode: key: cmd: desc: [
          mode
          key
          cmd
          {
            inherit desc;
            silent = true;
            buffer = true;
          }
        ];
      in {
        view = [
          (mkDiffviewKeymap "n" "q" "<CMD>DiffviewClose<CR>" "Diffview: Quit")

          (mkDiffviewKeymap "n" "[F" ''<CMD>lua require("diffview.actions").select_first_entry<CR>'' "Fist File")
          (mkDiffviewKeymap "n" "]F" ''<CMD>lua require("diffview.actions").select_last_entry<CR>'' "Last File")
          (mkDiffviewKeymap "n" "[f" ''<CMD>lua require("diffview.actions").select_prev_entry<CR>'' "Previous File")
          (mkDiffviewKeymap "n" "]f" ''<CMD>lua require("diffview.actions").select_next_entry<CR>'' "Next File")

          (mkDiffviewKeymap "n" "[m" ''<CMD>lua require("diffview.actions").prev_conflict<CR>'' "Next Conflict")
          (mkDiffviewKeymap "n" "]m" ''<CMD>lua require("diffview.actions").next_conflict<CR>'' "Previous Conflict")

          (mkDiffviewKeymap "n" "<leader>mo" ''<CMD>lua require("diffview.actions").conflict_choose("ours")<CR>'' "Choose OURS")
          (mkDiffviewKeymap "n" "<leader>mt" ''<CMD>lua require("diffview.actions").conflict_choose("theirs")<CR>'' "Choose THEIRS")
          (mkDiffviewKeymap "n" "<leader>mb" ''<CMD>lua require("diffview.actions").conflict_choose("base")<CR>'' "Choose BASE")
          (mkDiffviewKeymap "n" "<leader>ma" ''<CMD>lua require("diffview.actions").conflict_choose("all")<CR>'' "Choose ALL")
          (mkDiffviewKeymap "n" "<leader>mx" ''<CMD>lua require("diffview.actions").conflict_choose("none")<CR>'' "Delete conflict region")

          (mkDiffviewKeymap "n" "<leader>mO" ''<CMD>lua require("diffview.actions").conflict_choose_all("ours")<CR>'' "Choose OURS (whole file)")
          (mkDiffviewKeymap "n" "<leader>mT" ''<CMD>lua require("diffview.actions").conflict_choose_all("theirs")<CR>'' "Choose THEIRS (whole file)")
          (mkDiffviewKeymap "n" "<leader>mB" ''<CMD>lua require("diffview.actions").conflict_choose_all("base")<CR>'' "Choose BASE (whole file)")
          (mkDiffviewKeymap "n" "<leader>mA" ''<CMD>lua require("diffview.actions").conflict_choose_all("all")<CR>'' "Choose ALL (whole file)")
          (mkDiffviewKeymap "n" "<leader>mX" ''<CMD>lua require("diffview.actions").conflict_choose_all("none")<CR>'' "Delete conflict region (whole file)")
        ];
        file_panel = [
          (mkDiffviewKeymap "n" "q" "<CMD>DiffviewClose<CR>" "Diffview: Quit")
        ];
      };
    };
  };
}
