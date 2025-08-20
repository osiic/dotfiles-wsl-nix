{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    extraConfig = ''
      set -g status-style bg=default,fg=white
      set -g mouse on
      bind | split-window -h
      bind - split-window -v
    '';
  };
}
