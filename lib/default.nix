{lib}: {
  importAllNix = dir: 
    builtins.filter (lib.hasSuffix ".nix") 
    (lib.filesystem.listFilesRecursive dir);
}

