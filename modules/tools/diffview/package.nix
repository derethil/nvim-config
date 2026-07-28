{inputs, ...}: {
  flake-file.inputs.diffview-plus = {
    flake = false;
    url = "github:dlyongemallo/diffview-plus.nvim";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.diffview-plus-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "diffview.nvim";
      pname = "diffview-nvim";
      src = inputs.diffview-plus;

      meta = with lib; {
        description = "Maintained fork of original diffview plugin";
        homepage = "https://github.com/dlyongemallo/diffview-plus.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
