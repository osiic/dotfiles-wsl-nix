{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs; [
    # Git
    git
    curl
    wget
    fzf

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
    composer
    jdk
    julia
    python312Packages.pip
    tree-sitter
    nodejs_22
    neovim-unwrapped

    # shell
    tmux
    zsh
    starship

  ];

  imports = [
    ./modules/neovim.nix
  ];

  home.stateVersion = "25.05";
}

