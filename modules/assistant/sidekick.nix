{
  flake.modules.nvf.assistant-sidekick = {
    lib,
    pkgs,
    module ? {},
    ...
  }: let
    inherit (lib) mkIf;
    inherit (lib.nvim.binds) mkKeymap;
    config = module.config.sidekick or {};
  in {
    config = mkIf (config.enable or false) {
      vim = {
        lazy.plugins."sidekick.nvim" = {
          package = pkgs.vimPlugins.sidekick-nvim;
          setupModule = "sidekick";

          setupOpts = {
            cli = {
              mux = {
                backend = "tmux";
                create = "split";
                enabled = true;
              };

              picker = "fzf-lua";
              tools.codex = {};
            };

            nes.enabled = true;
          };

          keys = [
            (mkKeymap "n" "<leader>aa" "<CMD>lua require('sidekick.cli').toggle({ name = 'codex', focus = true })<CR>" {desc = "Codex: Toggle";})
            (mkKeymap "n" "<leader>ac" "<CMD>lua require('sidekick.cli').toggle({ name = 'codex', focus = true })<CR>" {desc = "Codex: Continue";})
            (mkKeymap "n" "<leader>ar" "<CMD>lua require('sidekick.cli').select({ filter = { name = 'codex' }, focus = true })<CR>" {desc = "Codex: Resume Session";})
            (mkKeymap "n" "<leader>af" "<CMD>lua require('sidekick.cli').focus({ name = 'codex' })<CR>" {desc = "Codex: Focus";})
            (mkKeymap "n" "<leader>am" "<CMD>lua require('sidekick.cli').select({ focus = true })<CR>" {desc = "Sidekick: Select CLI";})

            (mkKeymap "x" "<leader>aa" "<CMD>lua require('sidekick.cli').send({ name = 'codex', msg = '{selection}' })<CR>" {desc = "Codex: Send Selection";})
            (mkKeymap "x" "<leader>af" "<CMD>lua require('sidekick.cli').send({ name = 'codex', msg = '{selection}' })<CR>" {desc = "Codex: Send Selection";})
            (mkKeymap "n" "<leader>ab" "<CMD>lua require('sidekick.cli').send({ name = 'codex', msg = '{file}' })<CR>" {desc = "Codex: Send Current Buffer";})

            (mkKeymap "n" "<leader>aF" "<CMD>lua require('sidekick.cli.picker').open('files', { name = 'codex' })<CR>" {desc = "Codex: Find Files";})
            (mkKeymap "n" "<leader>ag" "<CMD>lua require('sidekick.cli.picker').open('grep', { name = 'codex' })<CR>" {desc = "Codex: Grep Files";})
            (mkKeymap "n" "<leader>aB" "<CMD>lua require('sidekick.cli.picker').open('buffers', { name = 'codex' })<CR>" {desc = "Codex: Find Buffers";})
            (mkKeymap "n" "<leader>aG" "<CMD>lua require('sidekick.cli.picker').open('git_files', { name = 'codex' })<CR>" {desc = "Codex: Find Git Files";})

            (mkKeymap "n" "<leader>ae" "<CMD>Sidekick nes update<CR>" {desc = "NES: Request Edit";})
            (mkKeymap "n" "<leader>aj" "<CMD>Sidekick nes jump<CR>" {desc = "NES: Jump to Edit";})
            (mkKeymap "n" "<leader>ay" "<CMD>Sidekick nes apply<CR>" {desc = "NES: Apply Edit";})
            (mkKeymap "n" "<leader>ax" "<CMD>Sidekick nes clear<CR>" {desc = "NES: Clear Edit";})
          ];
        };

        binds.whichKey.register."<leader>a" = "+AI";

        extraPackages = [
          config.package or pkgs.codex
          pkgs.lsof
        ];
      };
    };
  };
}
