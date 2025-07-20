{lib}: {
  util = {
    importAllNix = dir:
      builtins.filter (lib.hasSuffix ".nix")
      (lib.filesystem.listFilesRecursive dir);
  };

  icons = import ./icons.nix;
}
