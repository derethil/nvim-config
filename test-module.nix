{
  # Test module configuration for SonarLint
  # Used with: nix run .#test

  sonarlint = {
    enable = true;

    # languageServerPackage = null; # Use default (let it use the fallback)

    connectedMode = {
      enable = true;

      sonarqubeConnections = [
        {
          connectionId = "dragonarmy";
          serverUrl = "https://sonarqube.dragonarmy.rocks";
          disableNotifications = false;
        }
      ];

      projects = {
        "/Users/derethil/development/dragonarmy/hatchlab-srt" = {
          connectionId = "dragonarmy";
          projectKey = "dragon-army_hatchlab-srt_5a7d51c9-c50c-44fa-bd66-3ce24e000515";
          tokenFile = "/Users/derethil/development/dragonarmy/hatchlab-srt/token";
        };
      };
    };
  };
}
