{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        lib,
        ...
      }: let
        myLib = (import ./lib) {inherit lib;};

        nvim =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = myLib.importAllNix ./config;
          }).neovim;
      in {
        packages.default = nvim;
      };
    };
}
