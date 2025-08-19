{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${builtins.getEnv "USER"}";

  home.packages = with pkgs; [
    git
    neovim
    curl
    wget
    tmux
    zsh
    fzf
    lazygit
    starship
    nodejs_22
    python3Minimal
    xclip
  ];

  home.stateVersion = "25.05";
}

