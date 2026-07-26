{config, ...}: {
  perSystem = {pkgs, ...}: let
    package = (config.flake.lib.mkNvim {inherit pkgs;}).neovim;
    packageDev =
      (config.flake.lib.mkNvim {
        inherit pkgs;
        moduleConfig = config.flake.devModuleConfig;
      })
      .neovim;
  in {
    devShells.default = pkgs.mkShell {
      packages = [packageDev];

      shellHook = ''
        echo "nvf utilities available: nvf-print-config, nvf-print-config-path"
      '';
    };

    packages = {
      default = package;
      dev = packageDev;
    };
  };
}
