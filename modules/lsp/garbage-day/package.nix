{inputs, ...}: {
  flake-file.inputs.garbage-day-nvim = {
    flake = false;
    url = "github:Zeioth/garbage-day.nvim";
  };

  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.garbage-day-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "garbage-day-nvim";
      pname = "garbage-day-nvim";
      src = inputs.garbage-day-nvim;

      # https://github.com/Zeioth/garbage-day.nvim/pull/23
      # Fixes the FocusLost timer never being cancelled on FocusGained (issue #17),
      # which stops LSP clients out from under you even while focused.
      patches = [
        (pkgs.fetchpatch {
          url = "https://github.com/Zeioth/garbage-day.nvim/commit/9aad69d7a7fdad43c68a6c1f30f19348ccf9f891.patch";
          hash = "sha256-oROZsC9Flra24TRUA8Y1ghoWLEAqLOJHAWgpnrqP0kI=";
        })
      ];

      meta = with lib; {
        description = "Garbage collector that stops inactive LSP clients to free RAM";
        homepage = "https://github.com/Zeioth/garbage-day.nvim";
        license = licenses.mit;
        maintainers = [];
        platforms = platforms.all;
      };
    };
  };
}
