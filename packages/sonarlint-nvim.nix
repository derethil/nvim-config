{
  lib,
  vimUtils,
  inputs,
}:
vimUtils.buildVimPlugin {
  name = "sonarlint.nvim";
  pname = "sonarlint-nvim";
  src = inputs.sonarlint-nvim;
  meta = with lib; {
    description = "A wrapper for sonarlint-language-server with connected mode support";
    homepage = "https://gitlab.com/schrieveslaach/sonarlint.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}

