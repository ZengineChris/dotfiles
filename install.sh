#!/bin/bash
# Dotfiles installation script for Arch Linux

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages..."

# Check if yay is installed (for AUR packages)
if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
fi

# Install packages from list
if [ -f "$DOTFILES_DIR/packages.txt" ]; then
    echo "Installing packages from packages.txt..."
    yay -S --needed --noconfirm $(cat "$DOTFILES_DIR/packages.txt")
else
    echo "Warning: packages.txt not found"
fi

echo "==> Installing stow if needed..."
if ! command -v stow &> /dev/null; then
    sudo pacman -S --needed --noconfirm stow
fi

echo "==> Stowing dotfiles..."
cd "$DOTFILES_DIR"

# Stow packages
for dir in bash nvim git ghostty kitty hypr atuin sesh tm pm carapace starship jj; do
    if [ -d "$dir" ]; then
        echo "Stowing $dir..."
        stow -v -t ~ "$dir"
    fi
done

echo "==> Done! Dotfiles installed."
echo "Please restart your shell or run: source ~/.bashrc"
