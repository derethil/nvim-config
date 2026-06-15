{...}: {
  flake.lib.events = {
    VeryLazy = {
      event = "User";
      pattern = "LazyFile";
    };
  };
}
