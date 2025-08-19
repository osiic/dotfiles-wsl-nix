{ config, pkgs, ... }:

let
  nvimDir = builtins.getEnv "HOME" + "/.config/nvim";
in {

  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set runtimepath^=${nvimDir}
      '';
    };
  };

  # Jika folder nvim belum ada, fetch langsung dari GitHub
  home.file.".config/nvim".source = if builtins.pathExists nvimDir then
    nvimDir
  else
    builtins.fetchGit {
      url = "https://github.com/osiic/nvim.git";
      rev = "refs/heads/main"; # atau tag tertentu
    };
}

