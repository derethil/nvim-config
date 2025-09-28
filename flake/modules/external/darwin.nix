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
  package = import ../../package.nix {
    inherit lib pkgs inputs;
    system = pkgs.system;
    moduleConfig = cfg;
  };
in {
  imports = [
    (import ./options.nix {inherit lib inputs pkgs;})
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
