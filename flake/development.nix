{
  lib,
  inputs,
  system,
  ...
}: {
  # Development module configuration for testing
  # Used with: nix run .#dev

  nixpkgs.config.allowUnfree = true;

  # Enable Claude Code for testing
  claude = {
    enable = true;
  };
}
