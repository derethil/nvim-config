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
    kulala-nvim = {
      url = "github:mistweaverco/kulala.nvim";
      flake = false;
    };
    claudecode-nvim = {
      url = "github:coder/claudecode.nvim";
      flake = false;
    };
    claude-fzf-nvim = {
      url = "github:pittcat/claude-fzf.nvim";
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
        nvim =
          (import ./flake/package.nix {
            inherit lib pkgs inputs;
            moduleConfig = {};
          }).neovim;
      in {
        packages.default = nvim;
        devShells.default = pkgs.mkShell {
          packages = [nvim];
          shellHook = ''
            echo "nvf utilities available: nvf-print-config, nvf-print-config-path"
          '';
        };
      };

      flake = {lib, ...}: {
        nixosModules = {
          nvim-config = import ./flake/modules/nixos.nix {inherit lib inputs;};
        };

        homeManagerModules = {
          nvim-config = import ./flake/modules/home-manager.nix {inherit lib inputs;};
        };
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
