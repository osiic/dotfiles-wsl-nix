{ config, pkgs, lib, modulesPath, ... }:

{
  # User info
  home.username = "osiic";
  home.homeDirectory = "/home/osiic";

  # Wajib: enable home-manager module
  programs.home-manager.enable = true;

  # Paket yang mau di-install
  home.packages = with pkgs; [
    # Starter tools
    git
    curl
    wget
    fzf
    bat
    eza
    fd

    # Neovim & deps
    python3Minimal
    lazygit
    xclip
    stylua
    rust-analyzer
    gcc
    unzip
    ripgrep
    go
    rustc
    luarocks
    php
    php84Packages.cyclonedx-php-composer
    jdk
    julia
    python312Packages.pip
    tree-sitter
    nodejs_22
    nil
    nixpkgs-fmt
    neovim-unwrapped

    # Tmux
    tmux

    # Shell
    zsh
    starship
  ];

  # Import module tambahan
  # imports = [
  #  ./modules/neovim.nix
  #  ./modules/tmux.nix
  # ];

  # Versi state Home Manager (harus cocok sama channel yg dipakai)
  home.stateVersion = "24.11";
}
