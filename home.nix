{ config, pkgs, lib, modulesPath, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = "/home/${builtins.getEnv "USER"}";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Starter
    git curl wget fzf bat eza fd

    # Neovim deps
    python3Minimal lazygit xclip stylua rust-analyzer gcc unzip ripgrep go
    rustc luarocks php php84Packages.cyclonedx-php-composer jdk julia
    python312Packages.pip tree-sitter nodejs_22 nil nixpkgs-fmt neovim-unwrapped

    # Tmux
    tmux

    # Shell
    zsh starship
  ];

  imports = [
    ./modules/neovim.nix
    ./modules/tmux.nix
  ];

  home.stateVersion = "24.11";
}
