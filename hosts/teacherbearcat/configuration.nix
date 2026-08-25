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
    ./nfs.nix
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

  # Persist the measured battery-video winners across boot and AC/battery
  # transitions. TLP remains the only policy manager on this laptop.
  services.tlp.settings = {
    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
  };

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
