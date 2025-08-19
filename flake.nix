{
  description = "Dotfiles universal Nix + Home Manager 25.05";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      # Home Manager config
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

      # Tambah entry apps supaya bisa `nix run . switch`
      apps.${system}.switch = {
        type = "app";
        program = "${home-manager.packages.${system}.default}/bin/home-manager";
      };
    };
}
