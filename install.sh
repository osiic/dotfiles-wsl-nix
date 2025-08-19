#!/usr/bin/env bash
set -euo pipefail

# 1️⃣ Install Nix non-interactive
export NIX_INSTALL_NONINTERACTIVE=1
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# 2️⃣ Enable experimental features
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# 3️⃣ Source nix profile
. ~/.nix-profile/etc/profile.d/nix.sh

# 4️⃣ Clone dotfiles or update if already exists
if [ -d "$HOME/dotfiles-wsl-nix" ]; then
    cd "$HOME/dotfiles-wsl-nix" && git pull --rebase
else
    git clone https://github.com/osiic/dotfiles-wsl-nix.git "$HOME/dotfiles-wsl-nix"
    cd "$HOME/dotfiles-wsl-nix"
fi

# 5️⃣ Set USER env (Home Manager butuh)
export USER=$(whoami)

# 6️⃣ Build & activate Home Manager from flake
nix run .#homeConfigurations.default.activationPackage --impure

# ✅ Done
echo "✅ Done! Restart terminal untuk melihat shell & tools baru."
