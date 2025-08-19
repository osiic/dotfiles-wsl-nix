{ config, pkgs, ... }:

let
  nvimDir = "${config.home.homeDirectory}/.config/nvim";
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set runtimepath^=${nvimDir}
    '';
  };

  home.activation.postActivation = ''
    if [ ! -d "${nvimDir}" ]; then
      git clone -b own https://github.com/osiic/nvim.git "${nvimDir}"
    else
      cd "${nvimDir}" && git pull --rebase
    fi
  '';
}
