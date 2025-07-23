{
  lib,
  vimUtils,
  inputs,
  vimPlugins,
}:
vimUtils.buildVimPlugin {
  name = "blink-cmp-yanky";
  pname = "blink-cmp-yanky";
  src = inputs.blink-cmp-yanky;
  dependencies = [vimPlugins.blink-cmp];
  meta = with lib; {
    description = "Yanky source for blink.cmp";
    homepage = "https://github.com/marcoSven/blink-cmp-yanky";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
