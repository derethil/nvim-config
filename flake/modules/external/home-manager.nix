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
  unstablePkgs = inputs.nixpkgs.legacyPackages.${pkgs.system};
  package = import ../../package.nix {
    inherit lib inputs;
    pkgs = unstablePkgs;
    system = pkgs.system;
    moduleConfig = cfg;
  };
in {
  imports = [
    (import ./options.nix {inherit lib inputs; pkgs = unstablePkgs;})
  ];

  config = mkIf cfg.enable {
    home.packages = [package.neovim];
    home.sessionVariables = mkIf cfg.neovim.defaultEditor {
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
