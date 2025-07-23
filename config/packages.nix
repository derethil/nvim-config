{pkgs, ...}: {
  vim.extraPackages = with pkgs; [
    chafa
    diff-so-fancy
  ];
}
