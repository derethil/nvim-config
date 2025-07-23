{lib}: {
  util = {
    importAllNix = dir:
      builtins.filter (lib.hasSuffix ".nix")
      (lib.filesystem.listFilesRecursive dir);

    createUserCommand = {
      command,
      callback,
      opts ? {},
    }: ''
      vim.api.nvim_create_user_command("${command}", ${callback}, ${lib.generators.toLua {} opts})
    '';
  };

  icons = import ./icons.nix;
  events = import ./events.nix;
}
