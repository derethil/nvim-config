{
  pkgs,
  lib,
  ...
}: {
  vim.clipboard = {
    enable = true;
    providers = lib.mkIf (!pkgs.stdenv.isDarwin) {
      wl-copy.enable = true;
    };
    registers = "unnamedplus";
  };
}
