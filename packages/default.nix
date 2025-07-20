{
  pkgs,
  inputs,
  lib,
  ...
}: let
  files =
    builtins.filter (name: name != "default.nix")
    (builtins.attrNames (builtins.readDir ./.));

  names = map (name: lib.removeSuffix ".nix" name) files;

  packages = builtins.listToAttrs (map (name: {
      name = name;
      value = pkgs.callPackage (./. + "/${name}.nix") {inherit inputs;};
    })
    names);
in
  packages
