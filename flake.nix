{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake.url = "github:sodiboo/niri-flake/main";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nixos-hardware, catppuccin, niri-flake, ... }@inputs:
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
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
            niri-flake.nixosModules.niri
          ];
        };
      };
    };
}
