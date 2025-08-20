{ config, lib, pkgs, tmux-conf, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    mouse = true;

    # Baca langsung tmux.conf dari repo `osiic/tmux`
    extraConfig = builtins.readFile "${tmux-conf}/tmux.conf";
  };
}
