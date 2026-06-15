{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-file.flakeModules.dendritic];

  flake-file = {
    description = "My custom Neovim configuration";

    nixConfig = {
      extra-substituters = ["https://derethil.cachix.org"];
      extra-trusted-public-keys = ["derethil.cachix.org-1:4v8v6Oo2UHdB3FKutgQ2z3O9L++ukejhGvQFg6Pjsfc="];
    };

    outputs = lib.mkForce ''
      inputs@{flake-parts, import-tree, ...}:
      flake-parts.lib.mkFlake {inherit inputs;} (
        import-tree [
          ./flake
          ./modules
          ./outputs
          ./overlays
        ]
      )
    '';
  };
}
