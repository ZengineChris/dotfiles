# Dotfiles

Arch Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

### 1. Install packages

```bash
yay -S --needed $(cat packages.txt)
```

### 2. Stow configs

```bash
stow bash nvim git ghostty kitty hypr atuin sesh tm pm carapace starship jj tmux
```

Each directory is a stow package — running `stow <name>` creates symlinks from the repo into `~/`.

## Adding a new config

```bash
mkdir -p newapp/.config/newapp
cp -r ~/.config/newapp/* newapp/.config/newapp/
stow newapp
```

## Updating configs

Files are symlinked, so editing them in the repo is immediately reflected.
