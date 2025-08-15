{
  lib,
  vimUtils,
  inputs,
  vimPlugins,
  pkgs,
}:
let
  claudecode-nvim = pkgs.callPackage ./claudecode-nvim.nix { inherit inputs; };
in
vimUtils.buildVimPlugin {
  name = "claude-fzf-nvim";
  pname = "claude-fzf-nvim";
  src = inputs.claude-fzf-nvim;
  dependencies = [vimPlugins.snacks-nvim claudecode-nvim];
  # Remove problematic doc directory to avoid help tag generation issues
  postInstall = ''
    rm -rf $out/doc
  '';
  meta = with lib; {
    description = "FZF integration for Claude Code in Neovim.";
    homepage = "https://github.com/pittcat/claude-fzf.nvim";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
