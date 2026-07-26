{
  flake.modules.nvf.tools-git-ui = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      git.neogit = {
        enable = true;

        setupOpts = {
          commit_editor.staged_diff_split_kind = "auto";

          git_services."gitlab.dragonarmy.rocks" = {
            commit = "https://gitlab.dragonarmy.rocks/\${owner}/\${repository}/-/commit/\${oid}";
            pull_request = "https://gitlab.dragonarmy.rocks/\${owner}/\${repository}/merge_requests/new?merge_request[source_branch]=\${branch_name}";
            tree = "https://gitlab.dragonarmy.rocks/\${owner}/\${repository}/-/tree/\${branch_name}?ref_type=heads";
          };

          graph_style = "unicode";

          integrations = {
            diffview = true;
            fzf_lua = true;
            telescope = false;
          };
        };

        mappings = {
          commit = null;
          open = "<leader>gg";
          pull = null;
          push = null;
        };
      };

      keymaps = [
        (mkKeymap "n" "<leader>gG" "<CMD>lua require('neogit').open({ cwd = vim.fn.expand('%:p:h') })<CR>" {desc = "Neogit (cwd)";})
        (mkKeymap "n" "<leader>gl" "<CMD>lua require('neogit').action('log', 'log_current', { '--graph', '--decorate' })()<CR>" {desc = "Neogit Log (root directory)";})
        (mkKeymap "n" "<leader>gL" "<CMD>lua require('neogit').action('log', 'log_current', { '--', vim.fn.expand('%:p:h'), '--decorate' })()<CR>" {desc = "Neogit Log (cwd)";})
        (mkKeymap "n" "<leader>gf" "<CMD>lua require('neogit').action('log', 'log_current', { '--', vim.fn.expand('%:p'), '--decorate' })()<CR>" {desc = "Neogit Log (buffer)";})
        (mkKeymap "n" "<leader>gw" "<CMD>lua require('neogit').action('branch', 'checkout_create_branch')()<CR>" {desc = "Switch to New Branch";})
      ];
    };
  };
}
