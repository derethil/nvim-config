{...}: {
  flake.modules.nvf.ui-todo-comments = {
    vim.notes.todo-comments = {
      enable = true;
      mappings.quickFix = "<leader>sq";
    };
  };
}
