{
  description = "Dotfiles universal Nix + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Untuk Development
    # tmux-conf.url = "path:../tmux";
    # nvim-conf.url = "path:/home/osiic/.config/nvim";

    # Config dari repo luar
    tmux-conf.url = "github:osiic/tmux";
    nvim-conf.url = "github:osiic/nvim";
  };

  outputs = { self, nixpkgs, home-manager, tmux-conf, nvim-conf, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations.osiic = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          tmux-conf.homeManagerModules.tmux
          nvim-conf.homeManagerModules.nvim
        ];
      };
    };
}
