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
    close-buffers-nvim = {
      url = "github:kazhala/close-buffers.nvim";
      flake = false;
    };
    root-nvim = {
      url = "github:flashios09/root.nvim";
      flake = false;
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
        extendedLib = lib // (import ./lib {inherit lib;}) // inputs.nvf.lib;

        extendedPkgs = pkgs.extend (final: prev: {
          internal = import ./packages {inherit lib pkgs inputs;};
        });

        nvim =
          (inputs.nvf.lib.neovimConfiguration {
            pkgs = extendedPkgs;
            modules = extendedLib.util.importAllNix ./config;
            extraSpecialArgs = {
              lib = extendedLib;
              pkgs = extendedPkgs;
            };
          }).neovim;
      in {
        packages.default = nvim;
      };
    };
}
