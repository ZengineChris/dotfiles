# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Simple dotfiles repository for Arch Linux using GNU Stow for symlink management. No complex build systems - just config files and a package list.

## Structure

Each directory is a "stow package" containing configs for one application:

```
appname/
└── .config/appname/    # Or .appname for home dotfiles
    └── config files
```

Running `stow appname` creates symlinks from `~/dotfiles/appname/*` to `~/`.

## Key Files

- **install.sh**: Automated setup script (installs packages + stows configs)
- **packages.txt**: List of pacman/AUR packages (one per line)
- **.stowrc**: Stow configuration

## Common Operations

### Adding New Config

```bash
# Create stow package directory
mkdir -p newapp/.config/newapp

# Copy existing config
cp -r ~/.config/newapp/* newapp/.config/newapp/

# Stow it
stow newapp
```

### Updating Config

Configs are symlinked - just edit files in repo directly.

### Testing Stow Without Changes

```bash
stow -n appname  # Dry run, shows what would be linked
```

### Removing Config

```bash
stow -D appname  # Removes symlinks
```

### Managing Packages

Edit `packages.txt`, then:
```bash
yay -S --needed $(cat packages.txt)
```

## Application Configs

- **bash/**: Shell configuration (.bashrc with blesh, atuin, zoxide, fzf)
- **nvim/**: Neovim with lazy.nvim, LSP configs in .config/nvim/lsp/
- **git/**: Git ignore patterns
- **ghostty/**: Ghostty terminal config
- **kitty/**: Kitty terminal config and themes
- **hypr/**: Hyprland window manager (hyprland.conf)
- **atuin/**: Shell history (config.toml)
- **sesh/**: Session manager
- **tm/**: Task manager (your custom tool)
- **pm/**: Project manager (your custom tool)
- **carapace/**: Shell completion engine
- **starship/**: Shell prompt
- **jj/**: Jujutsu VCS

## Stow Path Structure

Stow expects this structure:
```
appname/
└── .config/appname/file  →  ~/.config/appname/file
└── .file                 →  ~/.file
```

## Package Management

All packages managed via pacman/yay:
- Official repos: neovim, git, kubectl, docker, etc.
- AUR: blesh-git, carapace-bin, sesh-bin, dgop, tm, pm

No Nix, no Homebrew - pure Arch.

## Development Workflow

When working with this repository:
1. Edit configs directly in their stow package directories
2. Changes are immediately reflected (files are symlinked)
3. Add new packages to packages.txt as needed
4. Test stow changes with `stow -n appname` before applying
5. Commit changes to git to track configuration evolution
