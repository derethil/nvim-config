{...}: {
  # Development module configuration for testing
  # Used with: nix run .#dev

  nixpkgs.config.allowUnfree = true;

  # Enable Claude Code for testing
  claude = {
    enable = true;
  };

  sonarlint = {
    enable = true;
    connectedMode = {
      enable = true;
      connections.sonarqube = [];
      projects = {};
    };
  };
}
