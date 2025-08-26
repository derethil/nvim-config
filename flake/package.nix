{
  lib,
  pkgs,
  inputs,
  system,
  moduleConfig,
}:
inputs.nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = let
    extendedLib = lib // (import ../lib {inherit lib;}) // inputs.nvf.lib;

    configModules = extendedLib.util.importAllNix ../config;

    # NOTE: Only use nightly until v0.11.4 is released. Nightly currently contains a critical fix for
    # LSP hover events not closing on buffer switch.
    neovimPackageModule = {
      vim.package = inputs.neovim-nightly-overlay.packages.${system}.neovim;
    };
  in
    configModules ++ [neovimPackageModule] ++ lib.optional (moduleConfig ? extraSettings) moduleConfig.extraSettings;
  extraSpecialArgs = {
    lib = lib // (import ../lib {inherit lib;}) // inputs.nvf.lib;
    pkgs = pkgs.extend (final: prev: {
      internal = import ../packages {inherit lib pkgs inputs;};
    });
    module.config = moduleConfig;
  };
}
