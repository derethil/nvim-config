# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "My custom Neovim configuration";

  inputs = {
    flake-file.url = "github:vic/flake-file";

    beam-nvim = {
      flake = false;
      url = "github:Piotr1215/beam.nvim";
    };

    calcium = {
      flake = false;
      url = "github:Necrom4/calcium.nvim";
    };

    close-buffers-nvim = {
      flake = false;
      url = "github:kazhala/close-buffers.nvim";
    };

    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts";
    };

    import-nvim = {
      flake = false;
      url = "github:piersolenski/import.nvim";
    };

    import-tree.url = "github:vic/import-tree";

    json2go = {
      flake = false;
      url = "github:olexsmir/json2go";
    };

    lualine-pretty-path = {
      flake = false;
      url = "github:bwpge/lualine-pretty-path";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-tsgo.url = "github:NixOS/nixpkgs/6368eda62c9775c38ef7f714b2555a741c20c72d";

    nvf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:notashelf/nvf";
    };

    nvim-tcss = {
      flake = false;
      url = "github:cachebag/nvim-tcss";
    };

    pedantix.url = "github:Swarsel/pedantix";

    sort-nvim = {
      flake = false;
      url = "github:sQVe/sort.nvim";
    };

    systems.url = "github:nix-systems/default";
  };

  nixConfig = {
    extra-substituters = ["https://derethil.cachix.org"];
    extra-trusted-public-keys = ["derethil.cachix.org-1:4v8v6Oo2UHdB3FKutgQ2z3O9L++ukejhGvQFg6Pjsfc="];
  };

  outputs = inputs @ {
    flake-parts,
    import-tree,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} (
      import-tree [
        ./flake
        ./modules
        ./outputs
        ./overlays
      ]
    );
}
