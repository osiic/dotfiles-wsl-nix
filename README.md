
# dotfiles-wsl-nix Universal Nix + Home Manager (25.05)

dotfiles-wsl-nix ini berbasis **Nix flakes** + **Home Manager**, bersifat universal:
- Bisa langsung digunakan di WSL/Ubuntu/NixOS.
- Semua paket, shell, alias, dan program otomatis ter-setup.
- Cocok untuk pengguna yang sering pindah device atau reinstall.

---

## 📦 Fitur Utama

- Paket default: `git`, `neovim`, `curl`, `wget`, `tmux`, `zsh`, `fzf`, `lazygit`, `starship`
- Shell: `zsh` + `Oh My Zsh`
- Shell alias:
  ```bash
  gs = git status
  gl = git log --oneline --graph --decorate
  v  = nvim
  ll = ls -alh
  ```

* Node.js & Python environment
* Starship prompt

---

## ⚡ Quick Setup (WSL / Linux)

```bash
#!/usr/bin/env bash
set -euo pipefail

# 1️⃣ Install Nix, Setup flace, Home Manager
export NIX_INSTALL_NONINTERACTIVE=1
sh <(curl -L https://nixos.org/nix/install) --no-daemon
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
. ~/.nix-profile/etc/profile.d/nix.sh
nix profile install nixpkgs#home-manager

# 2️⃣ Clone dotfiles
git clone https://github.com/osiic/dotfiles-wsl-nix.git ~/dotfiles-wsl-nix
cd ~/dotfiles-wsl-nix
git pull --rebase

# 3️⃣ Apply Home Manager configuration
export USER=$(whoami)
home-manager switch --flake .#default

echo "✅ Done! Restart terminal to see your new shell & tools."
```

> Semua paket, alias, shell, dan prompt akan otomatis aktif.
> Tidak perlu edit username atau home directory.

---

## 🔄 Update dotfiles-wsl-nix

Kalau ada update di repo:

```bash
cd ~/dotfiles-wsl-nix
git pull
home-manager switch --flake .#default --impure
```

---

## 🧩 Modular Configuration

Struktur dotfiles-wsl-nix modular agar mudah di-maintain:

```
dotfiles-wsl-nix/
├── flake.nix        # Flake entry point
├── home.nix         # Konfigurasi universal Home Manager
├── modules/
│   ├── shell.nix    # Alias, shell config
│   ├── neovim.nix   # Neovim setup
│   └── git.nix      # Git config
└── README.md
```

> Kamu bisa menambah modul baru di `modules/` dan tinggal import di `home.nix`.

---

## ⚠️ Catatan
* Pastikan selalu `--impure` karena konfigurasi mengambil environment lokal (`$USER`, `$HOME`).
* SSH keys tidak termasuk, gunakan metode tersendiri untuk SSH (privat repo atau secure storage).
