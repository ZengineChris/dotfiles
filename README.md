# Dotfiles

Personal dotfiles for Arch Linux, managed with GNU Stow.

## Features

- **Simple**: No complex build systems, just symlinks
- **Modular**: Each application in its own directory
- **Arch-native**: Uses pacman/yay for packages
- **Fast**: Instant setup with automated install script

## Prerequisites

- Arch Linux
- Git
- Base development tools (`base-devel`)

## Installation

```bash
# Clone repository
git clone https://github.com/ZengineChris/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run install script
./install.sh
```

This will:
1. Install yay (if needed)
2. Install all packages from packages.txt
3. Install stow
4. Symlink all configs to your home directory

## Structure

Each directory represents an application:
- `bash/` - Bash configuration
- `nvim/` - Neovim configuration
- `git/` - Git configuration
- `hypr/` - Hyprland window manager
- `kitty/` - Kitty terminal
- `ghostty/` - Ghostty terminal
- `atuin/` - Shell history manager
- `sesh/` - Session manager
- `tm/` - Task manager
- `pm/` - Project manager
- `carapace/` - Shell completion
- `starship/` - Shell prompt
- `jj/` - Jujutsu VCS

## Usage

### Adding New Config

```bash
# Create directory with proper structure
mkdir -p newapp/.config/newapp
cp ~/.config/newapp/* newapp/.config/newapp/

# Stow it
stow newapp
```

### Updating Config

Just edit files in the repo - they're symlinked!

### Removing Config

```bash
stow -D appname
```

### Managing Packages

Add packages to `packages.txt`, then:
```bash
yay -S --needed $(cat packages.txt)
```

## Tools Included

See `packages.txt` for full list. Highlights:
- **Shell**: bash + blesh + atuin + zoxide + fzf
- **Editor**: neovim with LSP
- **Terminal**: ghostty, kitty
- **Window Manager**: hyprland
- **Dev Tools**: git, kubectl, docker, and more
- **CLI Utils**: ripgrep, fd, bat, eza, yazi

## Customization

Each app's config is in its own directory. Edit directly:
```bash
vim ~/dotfiles/nvim/.config/nvim/init.lua
# Changes reflected immediately (symlinked)
```

## Updating

```bash
cd ~/dotfiles
git pull
# If new configs added:
stow newapp
```

## Uninstall

```bash
cd ~/dotfiles
stow -D bash nvim git ghostty kitty hypr atuin sesh tm pm carapace starship jj
```

## License

MIT
