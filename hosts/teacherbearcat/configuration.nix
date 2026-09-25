{ pkgs, ... }:

let
  sshPublicKeys = import ../ssh-public-keys.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ../../modules/nixos/profiles/niri
    ./nfs.nix
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
      "tsc=reliable"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users.erik.openssh.authorizedKeys.keys = [ sshPublicKeys.maniceraser ];

  networking.hostName = "teacherbearcat";

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

  system.stateVersion = "24.11";
}
