{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.filetree.neo-tree = {
    enable = true;
    setupOpts = {
      auto_clean_after_session_retore = true;
      hijack_netrw_behavior = "disabled";
      git_status_async = true;
    };
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>ft" "<CMD>Neotree action=focus position=right toggle=true reveal=true<CR>" {desc = "Toggle File Tree";})
  ];
}
