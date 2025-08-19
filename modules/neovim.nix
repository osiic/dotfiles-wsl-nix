{ config, pkgs, lib, ... }:

let
  nvimDir = "${config.home.homeDirectory}/.config/nvim";
  nvimRepo = "${config.home.homeDirectory}/.local/src/nvim"; # folder repo lokal
in {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # Buat symlink init.lua dari repo
  home.activation.linkNvim = lib.hm.dag.entryAfter [ "programs.neovim.enable" ] ''
    # Buat folder repo lokal kalau belum ada
    mkdir -p "${config.home.homeDirectory}/.local/src"

    # Clone repo kalau belum ada
    if [ ! -d "${nvimRepo}/.git" ]; then
      ${pkgs.git}/bin/git clone -b own https://github.com/osiic/nvim.git "${nvimRepo}"
    else
      cd "${nvimRepo}" && ${pkgs.git}/bin/git fetch --all && ${pkgs.git}/bin/git reset --hard origin/own
    fi

    # Buat symlink ke folder nvim
    ln -sfn "${nvimRepo}" "${nvimDir}"
  '';
}
