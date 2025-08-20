{
  description = "Dotfiles universal Nix + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tmux config dari repo luar
    tmux-conf.url = "github:osiic/tmux";

    # Neovim config dari repo luar juga (misal kamu punya `osiic/nvim`)
    nvim-conf = {
      url = "github:osiic/nvim";
      flake = false;
    };
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
          ./modules/neovim.nix
          tmux-conf.homeManagerModules.tmux

          # inject inputs supaya bisa dipakai di modul
          ({ ... }: {
            _module.args = {
              nvim-conf = nvim-conf;
            };
          })
        ];
      };
    };
}
