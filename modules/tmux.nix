{ config, pkgs, lib, ... }:

let
  tmuxDir = "${config.home.homeDirectory}/.config/tmux";
  tmuxRepo = "${config.home.homeDirectory}/.local/src/tmux"; # folder repo lokal
in {

  programs.tmux = {
    enable = true;
  };

  # Buat symlink config tmux dari repo
  home.activation.linkTmux = lib.hm.dag.entryAfter [ "programs.tmux.enable" ] ''
    # Buat folder repo lokal kalau belum ada
    mkdir -p "${config.home.homeDirectory}/.local/src"

    # Clone repo kalau belum ada
    if [ ! -d "${tmuxRepo}/.git" ]; then
      ${pkgs.git}/bin/git clone -b main https://github.com/osiic/tmux.git "${tmuxRepo}"
    else
      cd "${tmuxRepo}" && ${pkgs.git}/bin/git fetch --all && ${pkgs.git}/bin/git reset --hard origin/main
    fi

    # Buat symlink ke folder tmux
    ln -sfn "${tmuxRepo}" "${tmuxDir}"
  '';
}
