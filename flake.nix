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
    niri-flake.url = "github:epireyn/niri-flake/main";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    # nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.url = "github:eswanson224/nix-gaming";
    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      nixos-hardware,
      catppuccin,
      niri-flake,
      treefmt-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

      mkNixosConfiguration =
        {
          hostConfiguration,
          homeConfiguration,
          niriEnabled ? true,
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs niriEnabled; };
          modules = [
            hostConfiguration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = { inherit inputs niriEnabled; };
              home-manager.users.erik.imports = [
                homeConfiguration
                catppuccin.homeModules.catppuccin
              ];
            }
            nur.modules.nixos.default
          ]
          ++ extraModules
          ++ [
            catppuccin.nixosModules.catppuccin
            niri-flake.nixosModules.niri
          ];
        };
    in
    {
      nixosConfigurations = {
        maniceraser = mkNixosConfiguration {
          hostConfiguration = ./hosts/maniceraser/configuration.nix;
          homeConfiguration = ./hosts/maniceraser/home.nix;
        };

        teacherbearcat = mkNixosConfiguration {
          hostConfiguration = ./hosts/teacherbearcat/configuration.nix;
          homeConfiguration = ./hosts/teacherbearcat/home.nix;
          niriEnabled = true;
          extraModules = [
            nixos-hardware.nixosModules.lenovo-legion-16ach6h
          ];
        };
      };

      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatting = treefmtEval.config.build.check self;
    };
}
