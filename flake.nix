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
    import-nvim = {
      url = "github:piersolenski/import.nvim";
      flake = false;
    };
    sonarlint-nvim = {
      url = "gitlab:Alfaixx/sonarlint.nvim";
      flake = false;
    };
    blink-cmp-yanky = {
      url = "github:marcoSven/blink-cmp-yanky";
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

  nixConfig = {
    extra-substituters = [
      "https://derethil.cachix.org"
    ];
    extra-trusted-public-keys = [
      "derethil.cachix.org-1:4v8v6Oo2UHdB3FKutgQ2z3O9L++ukejhGvQFg6Pjsfc="
    ];
  };
}
