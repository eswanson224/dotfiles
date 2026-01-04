{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
      trusted-users = [
        "root"
        "@wheel"
        "erik"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "clocksource=hpet"
      "tsc=reliable"
    ];
  };

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";
  # services.automatic-timezoned.enable = true;
  # services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.libinput.enable = true;

  users.users.erik = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=erik"
      "--accept-routes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}

