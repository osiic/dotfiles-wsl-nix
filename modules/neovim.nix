{ config, pkgs, lib, ... }:

let
  homeDir = config.home.homeDirectory;
  nvimDir = "${homeDir}/.config/nvim";

  # Auto-detect dotfiles root - several options:

  # Option 1: Use environment variable (recommended)
  dotfilesRoot = builtins.getEnv "DOTFILES_ROOT";

  # Option 2: If you want to detect based on common dotfiles directory names
  # dotfilesRoot = 
  #   if builtins.pathExists "${homeDir}/dotfiles-wsl-nix" then "${homeDir}/dotfiles-wsl-nix"
  #   else if builtins.pathExists "${homeDir}/dotfiles" then "${homeDir}/dotfiles"
  #   else if builtins.pathExists "${homeDir}/.dotfiles" then "${homeDir}/.dotfiles"
  #   else throw "Could not find dotfiles directory";

  nvimRepo = "${dotfilesRoot}/package/nvim";
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  home.activation.linkNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Auto-detect dotfiles root if environment variable is not set
    if [ -z "${dotfilesRoot}" ]; then
      DOTFILES_ROOT=""
      for dir in "${homeDir}/dotfiles-wsl-nix" "${homeDir}/dotfiles" "${homeDir}/.dotfiles"; do
        if [ -d "$dir" ]; then
          DOTFILES_ROOT="$dir"
          break
        fi
      done
      if [ -z "$DOTFILES_ROOT" ]; then
        echo "Error: Could not find dotfiles directory"
        exit 1
      fi
      NVIM_REPO="$DOTFILES_ROOT/package/nvim"
    else
      NVIM_REPO="${nvimRepo}"
    fi
    
    mkdir -p "$(dirname "$NVIM_REPO")"
    
    if [ ! -d "$NVIM_REPO/.git" ]; then
      ${pkgs.git}/bin/git clone -b own https://github.com/osiic/nvim.git "$NVIM_REPO"
    else
      cd "$NVIM_REPO" && ${pkgs.git}/bin/git fetch --all && ${pkgs.git}/bin/git reset --hard origin/own
    fi
    
    # Remove existing nvim config if it's a symlink or directory
    if [ -L "${nvimDir}" ] || [ -d "${nvimDir}" ]; then
      rm -rf "${nvimDir}"
    fi
    
    ln -sfn "$NVIM_REPO" "${nvimDir}"
  '';
}
