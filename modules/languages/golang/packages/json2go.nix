{inputs, ...}: {
  flake-file.inputs.json2go = {
    flake = false;
    url = "github:olexsmir/json2go";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.json2go = pkgs.buildGoModule {
      pname = "json2go";
      src = inputs.json2go;
      vendorHash = "sha256-0t5ul0FHBJw+xt9rBTcZeKa1wdHCNvbrUYZB8pACGvY=";
      version = "unstable";

      meta = with lib; {
        description = "Convert JSON to Go struct";
        homepage = "https://github.com/olexsmir/json2go";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
