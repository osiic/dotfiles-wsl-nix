{ config, pkgs, ... }:

{
  # Ambil username & home directory otomatis
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # Paket default
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
  ];

  # Zsh + Oh My Zsh
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  # Shell alias
  programs.zsh.shellAliases = {
    gs = "git status";
    gl = "git log --oneline --graph --decorate";
    v  = "nvim";
    ll = "ls -alh";
  };

  # Node.js + Python
  programs.nodejs.enable = true;
  programs.python.enable = true;

  # Starship prompt
  programs.starship.enable = true;

  # State version Home Manager
  home.stateVersion = "25.05";
}

