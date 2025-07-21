{
  vim.binds.whichKey.register = {
    "<leader>m" = "+Git Conflict";
  };

  vim.git.git-conflict = {
    enable = true;
    setupOpts = {
      default_commands = true;
    };
    mappings = {
      both = "<leader>mb";
      none = "<leader>m0";
      ours = "<leader>mo";
      theirs = "<leader>mt";
      nextConflict = "]m";
      prevConflict = "[m";
    };
  };
}
