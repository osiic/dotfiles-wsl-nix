{ config, lib, pkgs, nvim-conf, ... }:

let
  nvimConfigDir = "${config.home.homeDirectory}/.config/nvim";
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.activation.linkNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${nvimConfigDir}"
    ln -sfn "${nvim-conf}" "${nvimConfigDir}"
  '';
}
