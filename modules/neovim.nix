{ config, pkgs, ... }:

let
  nvimDir = "${config.home.homeDirectory}/.config/nvim";
in {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Tambah konfigurasi ekstra runtimepath
    extraConfig = ''
      set runtimepath^=${nvimDir}
    '';
  };

  # Pre-activation hook: clone atau pull repo
  home.activation = {
    nvim = pkgs.writeShellScript "nvim-setup" ''
      if [ ! -d "${nvimDir}" ]; then
        git clone -b own https://github.com/osiic/nvim.git "${nvimDir}"
      else
        cd "${nvimDir}" && git pull --rebase
      fi
    '';
  };
}
