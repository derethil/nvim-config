{inputs, ...}: {
  # The nixpkgs pin behind `nixpkgs` lags Go toolchain rebuilds, which leaves
  # golangci-lint built against an older Go than what's configured for a
  # project (e.g. go 1.27), causing it to crash. Source it from
  # `nixpkgs-latest` instead, which tracks nixos-unstable independently.
  flake.overlays.golangci-lint = final: _prev: {
    golangci-lint = inputs.nixpkgs-latest.legacyPackages.${final.system}.golangci-lint;
  };
}
