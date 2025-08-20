{ config, pkgs, lib, modulesPath, ... }:

{
  # User info
  home.username = "osiic";
  home.homeDirectory = "/home/osiic";

  # Wajib: enable home-manager module
  programs.home-manager.enable = true;

home.packages = with pkgs; [
  # Starter tools
  git curl wget fzf bat eza fd

  # Neovim & dependencies
  neovim lazygit tree-sitter ripgrep stylua xclip gcc unzip

  # Language runtimes & tooling
  python3Full python312Packages.pip go rustc rust-analyzer luarocks 
  php php84Packages.cyclonedx-php-composer jdk julia nodejs_22 nil
  lua51Packages.jsregexp cargo 

  # Terminal tools
  tmux zsh starship
];

  # Versi state Home Manager (harus cocok sama channel yg dipakai)
  home.stateVersion = "24.11";
}
