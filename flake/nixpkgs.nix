{
  config,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  flake.lib.mkOverlayedPkgs = system: let
    flakeOverlays = builtins.attrValues config.flake.overlays;
  in let
    config = {
      allowDeprecatedx86_64Darwin = true;
      allowUnfree = true;
    };

    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system config;
    };

    bootstrapOverlay = _final: _prev: {
      stable = pkgs-stable;
    };
  in
    import inputs.nixpkgs {
      inherit system config;
      overlays = [bootstrapOverlay] ++ flakeOverlays;
    };

  perSystem = {system, ...}: {
    _module.args.pkgs = config.flake.lib.mkOverlayedPkgs system;
  };
}
