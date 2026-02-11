let
  files =
    builtins.filter (name: name != "default.nix")
    (builtins.attrNames (builtins.readDir ./.));

  overlays = map (file: import (./. + "/${file}")) files;
in
  overlays
