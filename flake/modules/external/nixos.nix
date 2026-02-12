{
  lib,
  inputs,
}: {
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.nvim-config;
  # Always use unstable nixpkgs from inputs, not the system's pkgs
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
    overlays =
      [(final: prev: {stable = pkgs-stable;})]
      ++ (import ../../../overlays);
  };
  package = import ../../package.nix {
    inherit lib inputs;
    pkgs = pkgs-unstable;
    moduleConfig = cfg;
  };
in {
  imports = [
    (import ./options.nix {
      inherit lib inputs;
      pkgs = pkgs-unstable;
    })
  ];

  config = mkIf cfg.enable {
    environment.systemPackages = [package.neovim];
    environment.variables = mkIf cfg.neovim.defaultEditor {
      EDITOR = "${package.neovim}/bin/nvim";
      VISUAL = "${package.neovim}/bin/nvim";
    };

    assertions = [
      {
        assertion = !(cfg.neovim.nightly && cfg.neovim.package != null);
        message = "Cannot enable both neovim.nightly and set a custom neovim.package. Choose one or the other.";
      }
    ];
  };
}
