{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.utility.diffview-nvim.enable = true;

  vim.git.neogit = {
    enable = true;
    mappings = {
      open = "<leader>gg";
      commit = null;
      pull = null;
      push = null;
    };
    setupOpts = {
      commit_editor = {
        staged_diff_split_kind = "auto";
      };
      integrations = {
        fzf_lua = true;
        telescope = false;
        diffview = true;
      };
      graph_style = "unicode";
      git_services = {
        "gitlab.dragonarmy.rocks" = {
          pull_request = "https://gitlab.dragonarmy.rocks/$${owner}/$${repository}/merge_requests/new?merge_request[source_branch]=$${branch_name}";
          commit = "https://gitlab.dragonarmy.rocks/$${owner}/$${repository}/-/commit/$${commit_hash}";
          tree = "https://gitlab.dragonarmy.rocks/$${owner}/$${repository}/-/tree/$${branch_name}";
        };
      };
    };
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>gG" "<CMD>lua require('neogit').open({ cwd = vim.fn.expand('%:p:h') })<CR>" {desc = "Neogit (cwd)";})
    (mkKeymap "n" "<leader>gl" "<CMD>lua require('neogit').action('log', 'log_current', { '--graph', '--decorate' })()<CR>" {desc = "Neogit Log (root directory)";})
    (mkKeymap "n" "<leader>gL" "<CMD>lua require('neogit').action('log', 'log_current', { '--', vim.fn.expand('%:p:h'), '--decorate' })()<CR>" {desc = "Neogit Log (cwd)";})
    (mkKeymap "n" "<leader>gf" "<CMD>lua require('neogit').action('log', 'log_current', { '--', vim.fn.expand('%:p'), '--decorate' })()<CR>" {desc = "Neogit Log (buffer)";})
    (mkKeymap "n" "<leader>gw" "<CMD>lua require('neogit').action('branch', 'checkout_create_branch')()<CR>" {desc = "Switch to New Branch";})
  ];
}
