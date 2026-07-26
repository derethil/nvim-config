{
  lib,
  inputs,
  ...
}: {
  flake-file = {
    description = "My custom Neovim configuration";

    formatter = pkgs:
      pkgs.writeShellApplication {
        name = "pedantix";
        runtimeInputs = [inputs.pedantix.packages.${pkgs.stdenv.hostPlatform.system}.pedantix-wrapped];
        text = ''exec pedantix --config ${inputs.self}/pedantix.toml "$@"'';
      };

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

    write-hooks = [
      {
        index = 10;

        program = pkgs:
          pkgs.writeShellApplication {
            name = "nix-flake-lock";
            runtimeInputs = [pkgs.nix];
            text = "nix flake lock";
          };
      }
    ];
  };

  imports = [inputs.flake-file.flakeModules.dendritic];
}
