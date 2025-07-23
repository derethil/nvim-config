{
  vim.binds.whichKey.register = {
    "<leader>gm" = "+Conflicts";
  };

  vim.git.git-conflict = {
    enable = true;
    setupOpts = {
      default_commands = true;
    };
    mappings = {
      both = "<leader>gmb";
      none = "<leader>gm0";
      ours = "<leader>gmo";
      theirs = "<leader>gmt";
      nextConflict = "]m";
      prevConflict = "[m";
    };
  };
}
