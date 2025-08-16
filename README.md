# Personal Neovim Configuration

This is my personal Neovim configuration built with
[nvf](https://github.com/notashelf/nvf).

## Features

- **AI Assistant**: Claude Code integration and GitHub Copilot
- **Language Support**: TypeScript, Python, Go, Nix, Lua, and more
- **Git Integration**: Neogit, git status, conflict resolution, blame viewer
- **Development**: Database interaction, HTTP client, task runner, session
  persistence

## Get Started

You can test it with:

```bash
nix run github:derethil/nvim-config
```

You might see requests to allow Cachix substituters (`derethil.cachix.org`)
during builds as I have set up a workflow to cache configuration builds on
Cachix.

## Installation

Add to your flake inputs:

```nix
nvim-config.url = "github:derethil/nvim-config";
```

Then import and enable:

```nix
# Home Manager
imports = [ inputs.nvim-config.homeManagerModules.default ];
programs.nvim-config.enable = true;

# NixOS  
imports = [ inputs.nvim-config.nixosModules.default ];
programs.nvim-config.enable = true;
```

More options can be found in [the options file](./flake/modules/options.nix).
