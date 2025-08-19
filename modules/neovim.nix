{ config, pkgs, lib, ... }:

let
  nvimDir = "${config.home.homeDirectory}/.config/nvim";
  nvimRepo = "${config.home.homeDirectory}/.local/src/nvim";
in {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.activation.linkNvim = lib.hm.dag.entryAfter [ "programs.neovim.enable" ] ''
    mkdir -p "${config.home.homeDirectory}/.local/src"

    if [ ! -d "${nvimRepo}/.git" ]; then
      ${pkgs.git}/bin/git clone -b own https://github.com/osiic/nvim.git "${nvimRepo}"
    else
      cd "${nvimRepo}" && ${pkgs.git}/bin/git fetch --all && ${pkgs.git}/bin/git reset --hard origin/own
    fi

    ln -sfn "${nvimRepo}" "${nvimDir}"
  '';
}
