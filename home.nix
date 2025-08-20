{ config, pkgs, lib, modulesPath, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${builtins.getEnv "USER"}";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Startter
    git
    curl
    wget
    fzf
    bat
    eza
    fd

    # neovim
    python3Minimal
    lazygit
    xclip
    stylua
    rust-analyzer
    gcc
    unzip
    ripgrep
    fd
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

    # shell
    zsh
    starship
  ];

  imports = [
    ./modules/neovim.nix
    ./modules/tmux.nix
  ];

  home.stateVersion = "24.11";
}
