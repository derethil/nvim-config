{
  flake.modules.nvf.tools-other-nvim = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) concatMap;
    inherit (lib.nvim.binds) mkKeymap;

    testTargets =
      map (target: {
        inherit target;
        context = "test";
      })
      (concatMap (location: concatMap (suffix: map (ext: "%1/${location}%2*.${suffix}.${ext}") ["ts" "tsx"]) ["test" "spec"]) ["" "__tests__/" "__spec__/"]);
  in {
    vim = {
      lazy.plugins."other.nvim" = {
        package = pkgs.vimPlugins.other-nvim;
        setupModule = "other-nvim";

        setupOpts = {
          mappings = [
            "golang"
            {
              pattern = "(.*)/([^/]+)%.tsx?$";
              target = testTargets;
            }
          ];

          showMissingFiles = false;
        };

        cmd = ["Other" "OtherTabNew" "OtherSplit" "OtherVSplit"];

        keys = [
          (mkKeymap "n" "<leader>vv" "<CMD>Other test<CR>" {desc = "Go to test";})
          (mkKeymap "n" "<leader>v-" "<CMD>OtherSplit test<CR>" {desc = "Go to test (split down)";})
          (mkKeymap "n" "<leader>v|" "<CMD>OtherVSplit test<CR>" {desc = "Go to test (split right)";})
        ];
      };

      binds.whichKey.register."<leader>v" = "+Test";
    };
  };
}
