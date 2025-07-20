{
  pkgs,
  inputs,
  ...
}: {
  close-buffers-nvim = pkgs.callPackage ./close-buffers-nvim.nix {inherit inputs;};
}
