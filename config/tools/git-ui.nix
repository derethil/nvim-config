{
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
        telescope = false; # TODO: enable when telescope is configured
      };
      graph_style = "unicode";
      git_services = {
        "gitlab.dragonarmy.rocks" = "https://gitlab.dragonarmy.rocks/$${owner}/$${repository}/merge_requests/new?merge_request[source_branch]=$${branch_name}";
      };
    };
  };

  vim.keymaps = [
    {
      key = "<leader>gG";
      mode = ["n"];
      lua = true;
      action = ''
        function()
          require("neogit").open({ cwd = vim.fn.expand("%:p:h") })
        end
      '';
      desc = "Neogit (cwd)";
    }
    {
      key = "<leader>gl";
      mode = ["n"];
      lua = true;
      action = ''
        function()
          require("neogit").action("log", "log_current", { "--graph", "--decorate" })()
        end
      '';
      desc = "Neogit Log (root directory)";
    }
    {
      key = "<leader>gL";
      mode = ["n"];
      lua = true;
      action = ''
        function()
          require("neogit").action("log", "log_current", { "--", vim.fn.expand("%:p:h"), "--decorate" })()
        end
      '';
      desc = "Neogit Log (cwd)";
    }
    {
      key = "<leader>gf";
      mode = ["n"];
      lua = true;
      action = ''
        function()
          require("neogit").action("log", "log_current", { "--", vim.fn.expand("%:p"), "--decorate" })()
        end
      '';
      desc = "Neogit Log (buffer)";
    }
    {
      key = "<leader>gw";
      mode = ["n"];
      lua = true;
      action = ''
        function()
          require("neogit").action("branch", "checkout_create_branch")()
        end
      '';
      desc = "Switch to New Branch";
    }
  ];
}
