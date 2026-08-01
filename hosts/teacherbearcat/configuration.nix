{ pkgs, ... }:

let
  sshPublicKeys = import ../ssh-public-keys.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ./mounts.nix
    ./packages.nix
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ../../modules/nixos/profiles/niri
  ];

  # Laptop-specific hybrid graphics topology; this does not apply to the
  # desktop host.
  hardware.nvidia.prime.amdgpuBusId = "PCI:6:0:0";

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

  users.users.erik.openssh.authorizedKeys.keys = [ sshPublicKeys.maniceraser ];

  networking.hostName = "teacherbearcat";
  # WiFi radio powersave stalls large CDN downloads (nix cache, discord cdn)
  # after lock/display-off; small requests survive. Independent of platform profile.
  networking.networkmanager.wifi.powersave = false;

  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=erik"
      "--accept-routes"
    ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
