{
  lib,
  pkgs,
  inputs,
  moduleConfig,
  ...
}:
inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = let
    extendedLib = lib // (import ../lib {inherit lib;}) // inputs.nvf.lib;
    config = extendedLib.util.importAllNix ../config;

    packageModule = lib.optionals (moduleConfig ? neovim) [
      (lib.mkIf (moduleConfig.neovim ? package && moduleConfig.neovim.package != null) {
        vim.package = moduleConfig.neovim.package;
      })
      (lib.mkIf (moduleConfig.neovim.nightly && (!(moduleConfig.neovim ? package) || moduleConfig.neovim.package == null)) {
        vim.package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
      })
    ];

    modules = config ++ [./modules] ++ packageModule;
    extraSettings = lib.optional (moduleConfig ? extraSettings) moduleConfig.extraSettings;
  in
    modules ++ extraSettings;
  extraSpecialArgs = {
    lib = lib // (import ../lib {inherit lib;}) // inputs.nvf.lib;
    pkgs = pkgs.extend (final: prev: {
      internal = import ../packages {inherit lib pkgs inputs;};
    });
    module.config = moduleConfig;
  };
}
