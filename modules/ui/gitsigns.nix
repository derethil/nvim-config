{
  flake.modules.nvf.ui-gitsigns = {lib, ...}: {
    vim = {
      binds.whichKey.register."<leader>gh" = "+Hunks";

      git.gitsigns = {
        enable = true;

        setupOpts = let
          signs = with lib.icons.git.signs; {
            add.text = added;
            change.text = modified;
            changedelete.text = modified;
            delete.text = removed;
            topdelete.text = removed;
            untracked.text = added;
          };
        in {
          signs = signs;
          signs_staged = signs;
        };

        codeActions.enable = true;

        mappings = {
          blameLine = "<leader>ghb";
          diffProject = "<leader>ghD";
          diffThis = "<leader>ghd";
          nextHunk = "]h";
          previousHunk = "[h";
          resetBuffer = "<leader>ghR";
          resetHunk = "<leader>ghr";
          stageBuffer = "<leader>ghS";
          stageHunk = "<leader>ghs";
          toggleBlame = "<leader>ghB";
          toggleDeleted = "<leader>ght";
          undoStageHunk = "<leader>ghu";
        };
      };
    };
  };
}
