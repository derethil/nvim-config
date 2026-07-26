{
  flake.modules.nvf.tools-git-conflict = {
    vim = {
      binds.whichKey.register."<leader>gm" = "+Conflicts";

      git.git-conflict = {
        enable = true;
        setupOpts.default_commands = true;

        mappings = {
          both = "<leader>gmb";
          nextConflict = "]m";
          none = "<leader>gm0";
          ours = "<leader>gmo";
          prevConflict = "[m";
          theirs = "<leader>gmt";
        };
      };
    };
  };
}
