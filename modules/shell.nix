{ config, pkgs, lib, ... }:

let
  zshPlugins = [
    {
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "master";
        sha256 = lib.fakeSha256;
      };
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-syntax-highlighting";
        rev = "master";
        sha256 = lib.fakeSha256;
      };
    }
    {
      name = "zsh-z";
      src = pkgs.fetchFromGitHub {
        owner = "agkozak";
        repo = "zsh-z";
        rev = "master";
        sha256 = lib.fakeSha256;
      };
    }
  ];
in
{
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = false; # kita pakai minimal setup
    shellAliases = {
      dev = "cd ~/projects/ && nvim .";
      proj = "cd ~/projects";
      ls = "exa --group-directories-first";
      ll = "exa -alF --group-directories-first --git";
      lt = "exa -T --group-directories-first --git-ignore";
      cat = "batcat --paging=never";
      grep = "rg";
      find = "fd";
      v = "nvim";
      g = "git";
      d = "docker";
      dc = "docker-compose";
      sz = "source ~/.zshrc";
    };
    shellInitExtra = ''
      # Load Zsh plugins
      ${lib.concatStringsSep "\n" (map (p: "source ${p.src}/$p.name/$p.name.zsh") zshPlugins)}

      # Environment Variables
      export PATH="$HOME/.local/bin:$PATH"
      export EDITOR="nvim"
      export VISUAL="nvim"
      export PAGER="less"
      export TERM="xterm-256color"
      export BAT_THEME="Dracula"

      # Git shortcuts
      alias gs='echo -e "\n\033[1;34m== Branches ==\033[0m" && git --no-pager branch --sort=-committerdate --color=always && echo -e "\n\033[1;34m== Last Commits ==\033[0m" && git --no-pager log --oneline -n 5 --decorate --color=always && echo -e "\n\033[1;34m== Stash List ==\033[0m" && git --no-pager stash list && echo -e "\n\033[1;34m== Remote Info ==\033[0m" && git remote -v && echo -e "\n\033[1;34m== Status ==\033[0m" && git status -sb --ahead-behind && echo -e "\n\033[1;34m== Diff (unstaged) ==\033[0m" && git --no-pager diff --stat'
      alias gb='git branch'
      alias gbd='git branch -D'
      alias gc='git checkout'
      alias gco='git checkout'
      alias gcb='git checkout -b'
      alias gac='git add . && git commit -m'
      alias gca='git commit -am'
      alias gcm='git commit -m'
      alias gp='git push'
      alias gpl='git pull'
      alias gf='git fetch'
      alias gss='git status -s'
      alias glg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
      alias gcp='git cherry-pick'
      alias gsu='git submodule update --init --recursive'
      alias gr='git restore .'
      alias grs='git reset --soft HEAD~1'
      alias gm='git merge'
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[[󰄛](green) ❯](peach)";
        error_symbol   = "[[󰄛](red) ❯](peach)";
        vimcmd_symbol  = "[󰄛 ❮](subtext1)";
      };
      git_branch.style = "bold mauve";
      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
