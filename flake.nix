{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/pull/488420/head";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    # niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, home-manager, nur, nixos-hardware, catppuccin, ... }@inputs:
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.erik = {
                imports = [
                  ./hosts/laptop/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
            }
            nur.modules.nixos.default
            nixos-hardware.nixosModules.lenovo-legion-16ach6h
            catppuccin.nixosModules.catppuccin
            # niri.nixosModules.niri
          ];
        };
      };
    };
}
