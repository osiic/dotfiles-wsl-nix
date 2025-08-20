#!/usr/bin/env bash
set -euo pipefail

# Install Nix non-interactive
export NIX_INSTALL_NONINTERACTIVE=1
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable experimental features
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Source nix profile
. ~/.nix-profile/etc/profile.d/nix.sh

# Install home-manager
nix profile add nixpkgs#home-manager

# Clone dotfiles or update if already exists
if [ -d "$HOME/dotfiles-wsl-nix" ]; then
    cd "$HOME/dotfiles-wsl-nix" && git reset --hard HEAD && git pull --rebase
else
    git clone https://github.com/osiic/dotfiles-wsl-nix.git "$HOME/dotfiles-wsl-nix"
    cd "$HOME/dotfiles-wsl-nix"
fi

# Set USER env (Home Manager butuh)
export USER=$(whoami)
export DOTFILES_ROOT=$(pwd)  

# Build & activate Home Manager from flake
home-manager switch --flake .#default --impure

# ✅ Done
echo "✅ Done! Restart terminal untuk melihat shell & tools baru."
