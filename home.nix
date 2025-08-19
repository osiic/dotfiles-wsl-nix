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
    neovim-unwrapped

    tmux
    zsh
    starship
    nodejs_22

  ];

  imports = [
    ./modules/neovim.nix
  ];

  home.stateVersion = "25.05";
}

