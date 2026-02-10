{
  lib,
  buildGoModule,
  inputs,
}:
buildGoModule {
  pname = "json2go";
  version = "unstable";
  src = inputs.json2go;
  vendorHash = null;
  meta = with lib; {
    description = "Convert JSON to Go struct";
    homepage = "https://github.com/olexsmir/json2go";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}

