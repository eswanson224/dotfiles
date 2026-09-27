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

  systemd.services.invidious-hourly-restart = {
    description = "Restart Invidious hourly";
    after = [ "docker.service" ];
    wants = [ "docker.service" ];

    # NixOS creates the corresponding systemd timer.
    startAt = "hourly";

    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = "/home/erik/projects/invidious";
      ExecStart = "${pkgs.docker}/bin/docker compose restart invidious invidious-db companion";
    };
  };

  services.suwayomi-server = {
    enable = true;
    settings.server.localSourcePath = "/var/lib/suwayomi-server/local";
  };

  services.adguardhome = {
    enable = true;
    port = 3003;
    settings = {};
  };

  # Optional: run once after boot if a scheduled restart was missed.
  systemd.timers.invidious-hourly-restart.timerConfig.Persistent = true;

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

  users.users.erik.openssh.authorizedKeys.keys = [
    sshPublicKeys.maniceraser
    sshPublicKeys.moshi
  ];

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
