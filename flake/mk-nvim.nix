{
  config,
  lib,
  inputs,
  ...
}: {
  flake-file.inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Builder for a fully-configured neovim package. Consumers (the per-system
  # `packages.default`/`packages.dev` outputs and the integration modules in
  # ../outputs/) call this with `pkgs` and an optional `moduleConfig` that
  # mirrors the `programs.nvim-config.*` user-facing schema.
  flake.lib.mkNvim = {
    pkgs,
    moduleConfig ? {},
  }: let
    inherit (lib) attrValues flatten optional;

    extendedLib = lib // config.flake.lib // inputs.nvf.lib;

    neovim = moduleConfig.neovim or {};
    customPackage = neovim.package or null;
    nightly = neovim.nightly or false;
    nightlyPackage = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;

    # Bridge from the user-facing `programs.nvim-config.neovim.{package,nightly}`
    # options into nvf's `vim.package`. Mutually exclusive — the integration
    # modules assert this.
    packageModule =
      if customPackage != null
      then [{vim.package = customPackage;}]
      else if nightly
      then [{vim.package = nightlyPackage;}]
      else [];

    extraSettings = moduleConfig.extraSettings or null;
  in
    inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = flatten [
        (attrValues config.flake.modules.nvf)
        packageModule
        (optional (extraSettings != null) extraSettings)
      ];
      extraSpecialArgs = {
        inherit inputs;
        lib = extendedLib;
        module.config = moduleConfig;
      };
    };
}
