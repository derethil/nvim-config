{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.binds.whichKey.register = {
    "<leader>o" = "Overseer";
  };

  vim.lazy.plugins."overseer.nvim" = {
    package = pkgs.vimPlugins.overseer-nvim;
    cmd = [
      "OverseerOpen"
      "OverseerClose"
      "OverseerToggle"
      "OverseerRun"
      "OverseerTaskAction"
      "OverseerRestartLast"
    ];
    setupModule = "overseer";
    setupOpts = {
      dap = false;
      bundles = {
        save_task_opts = {
          on_conflict = "overwrite";
        };
        autostart_on_load = true;
      };
      task_list = {
        bindings = {
          "<C-h>" = false;
          "<C-j>" = false;
          "<C-k>" = false;
          "<C-l>" = false;
        };
      };
      form = {
        win_opts = {
          winblend = 0;
        };
      };
      confirm = {
        win_opts = {
          winblend = 0;
        };
      };
      task_win = {
        win_opts = {
          winblend = 0;
        };
      };
    };
    keys = [
      (mkKeymap "n" "<leader>ow" "<cmd>OverseerToggle<cr>" {desc = "Task list";})
      (mkKeymap "n" "<leader>oo" "<cmd>OverseerRun<cr>" {desc = "Run task";})
      (mkKeymap "n" "<leader>oq" "<cmd>OverseerQuickAction<cr>" {desc = "Action recent task";})
      (mkKeymap "n" "<leader>ot" "<cmd>OverseerTaskAction<cr>" {desc = "Task action";})
      {
        key = "<space>or";
        mode = ["n" "x" "v"];
        desc = "Restart Last Task";
        lua = true;
        action =
          /*
          lua
          */
          ''
            function()
              local overseer = require("overseer")
              vim.cmd("OverseerRestartLast")

              -- Don't do anything if there are no tasks
              local status = { overseer.STATUS.RUNNING, overseer.STATUS.PENDING }
              local most_recent = overseer.list_tasks({ status = status, recent_first = true })[1]
              if not most_recent then
                return
              end

              vim.notify("Restarted last Overseer task: " .. most_recent.name, vim.log.levels.INFO, { title = "Overseer" })
            end
          '';
      }
    ];
  };

  vim.usercmds = [
    {
      name = "OverseerRestartLast";
      command =
        lib.generators.mkLuaInline
        /*
        lua
        */
        ''
          function()
            local overseer = require("overseer")
            local tasks = overseer.list_tasks({ recent_first = true })
            if vim.tbl_isempty(tasks) then
              vim.notify("No tasks found", vim.log.levels.WARN)
            else
              overseer.run_action(tasks[1], "restart")
            end
          end
        '';
      desc = "Restart the most recent Overseer task";
    }
  ];
}
