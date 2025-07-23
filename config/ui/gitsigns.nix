{lib, ...}: {
  vim.binds.whichKey.register = {
    "<leader>gh" = "+Hunks";
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
      signs = with lib.icons.git.signs; {
        add = {text = added;};
        change = {text = modified;};
        delete = {text = removed;};
        topdelete = {text = removed;};
        changedelete = {text = modified;};
        untracked = {text = added;};
      };
    in {
      signs = signs;
      signs_staged = signs;
    };
  };
}
