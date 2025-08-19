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
chmod +x install.sh && ./install.sh
```

> Semua paket, alias, shell, dan prompt akan otomatis aktif.
> Tidak perlu edit username atau home directory.

---

## 🔄 Update dotfiles-wsl-nix

Kalau ada update di repo:

```bash
cd ~/dotfiles-wsl-nix && git reset --hard HEAD && git pull --rebase && home-manager switch --flake .#default --impure
```

## 🔄 Romove garbage package

Kalau mau hapus semua paket dan environment Nix lama yang tidak terpakai:
```bash
sudo nix-collect-garbage -d && nix-env --delete-generations +1
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
