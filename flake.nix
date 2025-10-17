{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
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
    beam-nvim = {
      url = "github:Piotr1215/beam.nvim";
      flake = false;
    };
    nvim-tcss = {
      url = "github:cachebag/nvim-tcss";
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
        package = import ./flake/package.nix {
          inherit lib pkgs inputs;
          moduleConfig = {};
        };

        packageDev = import ./flake/package.nix {
          inherit lib inputs;
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          moduleConfig = import ./flake/development.nix {
            inherit lib inputs system;
          };
        };
      in {
        packages.default = package.neovim;
        packages.dev = packageDev.neovim;
        devShells.default = pkgs.mkShell {
          packages = [packageDev.neovim];
          shellHook = ''
            echo "nvf utilities available: nvf-print-config, nvf-print-config-path"
          '';
        };
      };

      flake = {lib, ...}: {
        nixosModules = {
          nvim-config = import ./flake/modules/external/nixos.nix {inherit lib inputs;};
        };

        homeManagerModules = {
          nvim-config = import ./flake/modules/external/home-manager.nix {inherit lib inputs;};
        };

        darwinModules = {
          nvim-config = import ./flake/modules/external/darwin.nix {inherit lib inputs;};
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
