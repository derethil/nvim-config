# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "My custom Neovim configuration";

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree [
      ./flake
      ./modules
      ./outputs
      ./overlays
    ]);

  nixConfig = {
    extra-substituters = [ "https://derethil.cachix.org" ];
    extra-trusted-public-keys = [
      "derethil.cachix.org-1:4v8v6Oo2UHdB3FKutgQ2z3O9L++ukejhGvQFg6Pjsfc="
    ];
  };

  inputs = {
    beam-nvim = {
      url = "github:Piotr1215/beam.nvim";
      flake = false;
    };
    calcium = {
      url = "github:Necrom4/calcium.nvim";
      flake = false;
    };
    close-buffers-nvim = {
      url = "github:kazhala/close-buffers.nvim";
      flake = false;
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    gopher-nvim = {
      url = "github:olexsmir/gopher.nvim";
      flake = false;
    };
    import-nvim = {
      url = "github:piersolenski/import.nvim";
      flake = false;
    };
    import-tree.url = "github:vic/import-tree";
    json2go = {
      url = "github:olexsmir/json2go";
      flake = false;
    };
    lualine-pretty-path = {
      url = "github:bwpge/lualine-pretty-path";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-tsgo.url = "github:NixOS/nixpkgs/6368eda62c9775c38ef7f714b2555a741c20c72d";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-tcss = {
      url = "github:cachebag/nvim-tcss";
      flake = false;
    };
    sort-nvim = {
      url = "github:sQVe/sort.nvim";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
  };
}
