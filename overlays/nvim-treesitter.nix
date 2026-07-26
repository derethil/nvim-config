{
  flake.overlays.nvim-treesitter = final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      _plugins-final: plugins-prev: {
        nvim-treesitter = plugins-prev.nvim-treesitter.overrideAttrs (oldAttrs: {
          src = final.applyPatches {
            patches = [./patches/nvim-treesitter-go-string-priority.patch];
            src = oldAttrs.src;
          };
        });
      }
    );
  };
}
