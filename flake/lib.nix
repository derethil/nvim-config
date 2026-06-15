{lib, ...}: {
  # Freeform `flake.lib` namespace. Concrete helpers and data live under
  # ../modules/lib/ (each contributes one top-level key here).
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
  };
}
