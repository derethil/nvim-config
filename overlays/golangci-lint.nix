{inputs, ...}: {
  # Keep Go analyzers compatible with newer project toolchains without
  # updating the package pin used by the rest of Neovim.
  flake.overlays.golangci-lint = final: _prev: {
    inherit (inputs.nixpkgs-latest.legacyPackages.${final.stdenv.hostPlatform.system})
      gopls
      golangci-lint
      ;
  };
}
