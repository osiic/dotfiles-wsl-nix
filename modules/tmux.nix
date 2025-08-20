{ config, pkgs, lib, ... }:

let
  tmuxRepo = builtins.fetchGit {
    url = "https://github.com/osiic/tmux.git";
    ref = "main"; # atau branch lain
  };
in {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    extraConfig = builtins.readFile "${tmuxRepo}/tmux.conf";
  };
}
