<div align="center">

<h3>
  ❄️ derethil/nvim-config
</h3>

</div>

# About

My Neovim setup, packaged with [nvf](https://github.com/notashelf/nvf) and
flake-parts, organized using the
[dendritic pattern](https://github.com/Doc-Steve/dendritic-design-with-flake-parts).

## Layout

- `flake/` - flake-parts plumbing (nixpkgs, mk-nvim, flake-file, etc.)
- `modules/` - nvf modules, organized by topic
- `outputs/` - NixOS / home-manager / nix-darwin integration modules and the
  `packages.{default,dev}` outputs
- `overlays/` - flake-wide package overrides

## Features

- **AI**: Claude Code integration, GitHub Copilot
- **Languages**: TypeScript, Python, Go, Nix, Lua, and more
- **Git**: Neogit, gitsigns, conflict resolution, blame, diffview
- **Editor**: mini.* suite, snacks.nvim, flash, blink-cmp, fzf-lua
- **Development**: database client, HTTP client, session restoration, SonarLint

# Try it

```bash
nix run github:derethil/nvim-config
```

# As a flake input

```nix
nvim-config.url = "github:derethil/nvim-config";
```

```nix
# Home Manager
imports = [ inputs.nvim-config.homeManagerModules.nvim-config ];
programs.nvim-config.enable = true;

# NixOS
imports = [ inputs.nvim-config.nixosModules.nvim-config ];
programs.nvim-config.enable = true;

# nix-darwin
imports = [ inputs.nvim-config.darwinModules.nvim-config ];
programs.nvim-config.enable = true;
```

See [`outputs/options.nix`](./outputs/options.nix) for the full option set.
