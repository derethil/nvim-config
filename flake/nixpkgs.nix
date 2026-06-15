{
  config,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # Pinned to the last nixpkgs commit before typescript-go became unstable (2026-04-24 build)
    nixpkgs-tsgo.url = "github:NixOS/nixpkgs/6368eda62c9775c38ef7f714b2555a741c20c72d";
  };

  flake.lib.mkOverlayedPkgs = system: let
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-tsgo = import inputs.nixpkgs-tsgo {
      inherit system;
      config.allowUnfree = true;
    };
    bootstrapOverlay = _final: _prev: {
      stable = pkgs-stable;
      typescript-go = pkgs-tsgo.typescript-go;
    };
  in
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [bootstrapOverlay] ++ builtins.attrValues config.flake.overlays;
    };

  perSystem = {system, ...}: {
    _module.args.pkgs = config.flake.lib.mkOverlayedPkgs system;
  };
}
