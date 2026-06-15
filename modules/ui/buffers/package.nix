{inputs, ...}: {
  flake-file.inputs.close-buffers-nvim = {
    url = "github:kazhala/close-buffers.nvim";
    flake = false;
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.close-buffers-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "close-buffers.nvim";
      pname = "close-buffers-nvim";
      src = inputs.close-buffers-nvim;
      meta = with lib; {
        description = "Delete multiple vim buffers based on different conditions";
        homepage = "https://github.com/kazhala/close-buffers.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
