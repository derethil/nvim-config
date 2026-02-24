{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins.garbage-day-nvim = {
    package = pkgs.internal.garbage-day-nvim;
    setupModule = "garbage-day";
    event = [lib.events.VeryLazy];
    setupOpts = {
      grace_period = 30;
      excluded_lsp_clients = ["copilot" "null-ls"];
      notifications = true;
    };
  };
}
