{
  lib,
  pkgs,
  inputs,
  moduleConfig,
}:
inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = let
    extendedLib = lib // (import ../lib {inherit lib;}) // inputs.nvf.lib;
    config = extendedLib.util.importAllNix ../config;
    modules = config ++ [./modules];
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
