{ config, pkgs, ... }:

{
  # Ambil username & home directory otomatis
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${builtins.getEnv "USER"}";

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
    nodejs_22
    python3Full
  ];

  # Shell alias
  programs.zsh.shellAliases = {
    gs = "git status";
    gl = "git log --oneline --graph --decorate";
    v  = "nvim";
    ll = "ls -alh";
  };

  # Starship prompt
  programs.starship.enable = true;

  # State version Home Manager
  home.stateVersion = "25.05";
}

