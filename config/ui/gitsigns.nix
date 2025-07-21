{
  vim.binds.whichKey.register = {
    "<leader>gh" = "+hunks";
  };

  vim.git.gitsigns = {
    enable = true;
    codeActions.enable = true;
    mappings = {
      blameLine = "<leader>ghb";
      toggleBlame = "<leader>ghB";
      diffThis = "<leader>ghd";
      diffProject = "<leader>ghD";
      nextHunk = "]h";
      previousHunk = "[h";
      resetHunk = "<leader>ghr";
      resetBuffer = "<leader>ghR";
      stageHunk = "<leader>ghs";
      stageBuffer = "<leader>ghS";
      undoStageHunk = "<leader>ghu";
      toggleDeleted = "<leader>ght";
    };
    setupOpts = let
      signs = {
        add = {text = "▎";};
        change = {text = "▎";};
        delete = {text = "";};
        topdelete = {text = "";};
        changedelete = {text = "▎";};
        untracked = {text = "▎";};
      };
    in {
      signs = signs;
      signs_staged = signs;
    };
  };
}
