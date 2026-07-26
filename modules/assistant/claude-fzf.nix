{
  flake.modules.nvf.assistant-claude-fzf = {
    lib,
    pkgs,
    module ? {},
    ...
  }: let
    inherit (lib) mkIf;
    inherit (lib.nvim.binds) mkKeymap;
    cfg = module.config.claude or {};
  in {
    config = mkIf (cfg.enable or false) {
      vim = {
        lazy.plugins."claude-fzf.nvim" = {
          package = pkgs.vimPlugins.claude-fzf-nvim.overrideAttrs (_: {
            dependencies = [];
          });

          setupModule = "claude-fzf";

          setupOpts = {
            auto_context = true;
            batch_size = 10;

            fzf_opts.winopts = {
              backdrop = 60;
              height = 0.85;
              width = 0.8;
            };
          };

          keys = [
            (mkKeymap "n" "<leader>aF" "<CMD>silent! ClaudeFzfFiles<CR>" {desc = "Claude: Find Files";})
            (mkKeymap "n" "<leader>ag" "<CMD>silent! ClaudeFzfGrep<CR>" {desc = "Claude: Grep Files";})
            (mkKeymap "n" "<leader>aB" "<CMD>silent! ClaudeFzfBuffers<CR>" {desc = "Claude: Find Buffers";})
            (mkKeymap "n" "<leader>aG" "<CMD>silent! ClaudeFzfGitFiles<CR>" {desc = "Claude: Find Git Files";})
          ];
        };

        binds.whichKey.register."<leader>a" = "+AI";
      };
    };
  };
}
