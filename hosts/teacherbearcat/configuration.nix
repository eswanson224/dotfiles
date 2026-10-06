{ lib, pkgs, ... }:

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
    ./samba.nix
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
    settings = { };
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
      "consoleblank=60"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users.erik.openssh.authorizedKeys.keys = [
    sshPublicKeys.maniceraser
    sshPublicKeys.moshi
  ];

  networking.hostName = "teacherbearcat";

  services.xserver.autorun = false;
  services.xserver.displayManager.lightdm.enable = false;

  hardware.nvidia = {
    dynamicBoost.enable = true;
    powerManagement.finegrained = true;
  };

  # Keep Dynamic Boost available on demand, but don't let nvidia-powerd
  # prevent the discrete GPU from suspending during headless boots.
  systemd.services.nvidia-powerd.wantedBy = lib.mkForce [ ];

  # Let the NVIDIA HDMI audio PCI function runtime-suspend with the GPU.
  services.udev.extraRules = ''
    ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", TEST=="power/control", ATTR{power/control}="auto"
  '';

  services.tlp.settings = {
    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
  };

  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  system.stateVersion = "24.11";
}
