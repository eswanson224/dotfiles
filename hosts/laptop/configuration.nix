{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  nix = {
    settings = {
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
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "clocksource=hpet"
      # "hpet=disable"
      "tsc=reliable"
    ];
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };

  users.users.erik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
      "docker"
    ];
  };

  networking.hostName = "teacherbearcat";

  system.stateVersion = "24.11"; # Did you read the comment?
}
