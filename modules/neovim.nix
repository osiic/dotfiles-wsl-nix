{ config, pkgs, ... }:

let
  nvimDir = "${config.home.homeDirectory}/.config/nvim";
in {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # extraConfig bisa kosong, karena kita pakai init.lua dari repo
    extraConfig = ''
      " runtimepath akan otomatis mengikuti nvimDir
    '';
  };

  # Pastikan folder nvim ada, clone atau pull repo
  home.activation.postActivation = ''
    # Backup init.lua lama kalau ada
    if [ -f "${nvimDir}/init.lua" ]; then
      mv "${nvimDir}/init.lua" "${nvimDir}/init.lua.backup"
    fi

    # Clone repo kalau belum ada
    if [ ! -d "${nvimDir}" ]; then
      ${pkgs.git}/bin/git clone -b own https://github.com/osiic/nvim.git "${nvimDir}"
    elif [ -d "${nvimDir}/.git" ]; then
      cd "${nvimDir}" && ${pkgs.git}/bin/git reset --hard HEAD && ${pkgs.git}/bin/git pull --rebase
    else
      rm -rf "${nvimDir}"
      ${pkgs.git}/bin/git clone -b own https://github.com/osiic/nvim.git "${nvimDir}"
    fi
  '';
}
