{ config, pkgs, ... }:

let
  nvimDir = builtins.getEnv "HOME" + "/.config/nvim";
in {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;

    # Ganti deprecated 'configure' dengan 'extraConfig'
    extraConfig = ''
      set runtimepath^=${nvimDir}
    '';
  };

  # Auto clone repo jika folder belum ada
  home.file.".config/nvim".source = if builtins.pathExists nvimDir then
    nvimDir
  else
    builtins.fetchGit {
      url = "https://github.com/osiic/nvim.git";
      rev = "refs/heads/main";
    };
}

