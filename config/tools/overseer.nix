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
      "OverseerSaveBundle"
      "OverseerLoadBundle"
      "OverseerDeleteBundle"
      "OverseerRunCmd"
      "OverseerRun"
      "OverseerInfo"
      "OverseerBuild"
      "OverseerQuickAction"
      "OverseerTaskAction"
      "OverseerClearCache"
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
      (mkKeymap "n" "<leader>oi" "<cmd>OverseerInfo<cr>" {desc = "Overseer Info";})
      (mkKeymap "n" "<leader>ob" "<cmd>OverseerBuild<cr>" {desc = "Task builder";})
      (mkKeymap "n" "<leader>ot" "<cmd>OverseerTaskAction<cr>" {desc = "Task action";})
      (mkKeymap "n" "<leader>oc" "<cmd>OverseerClearCache<cr>" {desc = "Clear cache";})
      {
        key = "<space>or";
        mode = ["n" "x" "v"];
        desc = "Restart Last Task";
        lua = true;
        action = ''
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

  vim.autocmds = [
    {
      event = ["User"];
      pattern = ["PersistenceSavePre"];
      desc = "Save Overseer tasks during Persistence session save";
      callback = lib.generators.mkLuaInline ''
        function()
          local function get_cwd_as_name()
            local dir = vim.fn.getcwd(0)
            return dir:gsub("[^A-Za-z0-9]", "_")
          end

          local overseer = require("overseer")
          overseer.save_task_bundle(get_cwd_as_name(), nil, { on_conflict = "overwrite" })
        end
      '';
    }
    {
      event = ["User"];
      pattern = ["PersistenceLoadPost"];
      desc = "Load Overseer tasks during Persistence session load";
      callback = lib.generators.mkLuaInline ''
        function()
          local function get_cwd_as_name()
            local dir = vim.fn.getcwd(0)
            return dir:gsub("[^A-Za-z0-9]", "_")
          end

          local overseer = require("overseer")
          overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })

          -- List loaded tasks to notify user
          local status = { overseer.STATUS.RUNNING, overseer.STATUS.PENDING }
          local tasks = overseer.list_tasks({ status = status })
          local message = "Restored " .. #tasks .. " Overseer task" .. (#tasks == 1 and "" or "s")
          if #tasks > 0 then
            vim.notify(message, vim.log.levels.INFO, { title = "Overseer" })
          end
        end
      '';
    }
  ];
}
