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
  nvimPackage = import ../package.nix {
    inherit lib pkgs inputs;
    system = pkgs.system;
    moduleConfig = cfg;
  };
in {
  imports = [
    (import ./options.nix {inherit lib inputs pkgs;})
  ];

  config = mkIf cfg.enable {
    home.packages = [nvimPackage.neovim];
    home.sessionVariables = mkIf cfg.defaultEditor {
      EDITOR = "${nvimPackage.neovim}/bin/nvim";
      VISUAL = "${nvimPackage.neovim}/bin/nvim";
    };
  };
}
