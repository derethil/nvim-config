{
  inputs,
  system,
}: let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays =
      [(final: prev: {stable = pkgs-stable;})]
      ++ (import ../../../overlays);
  };
in {
  inherit pkgs-unstable pkgs-stable;
}
