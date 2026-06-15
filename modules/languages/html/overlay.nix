{...}: {
  # superhtml on unstable nixpkgs is currently broken; pin to the stable channel.
  flake.overlays.superhtml = _final: prev: {
    superhtml = prev.stable.superhtml;
  };
}
