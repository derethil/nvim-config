{
  pkgs,
  inputs,
  lib,
  ...
}: let
  files =
    builtins.filter (name: name != "default.nix")
    (builtins.attrNames (builtins.readDir ./.));

  packages = builtins.listToAttrs (map (file: {
      name = lib.removeSuffix ".nix" file;
      value = pkgs.callPackage (./. + "/${file}") {inherit inputs;};
    })
    files);
in
  packages
