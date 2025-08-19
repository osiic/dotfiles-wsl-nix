{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = with pkgs; [
    # Git
    git

    # neovim
    neovim-unwrapped

    
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

  imports = [
    ./modules/neovim.nix
  ];

  home.stateVersion = "25.05";
}

