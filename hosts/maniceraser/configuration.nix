{ pkgs, lib, ... }:

let
  sshPublicKeys = import ../ssh-public-keys.nix;
in
{
  imports = [
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ../../modules/nixos/profiles/kde
    ./hardware-configuration.nix
    ./nfs.nix
    ./packages.nix
  ];

  users.users.erik.openssh.authorizedKeys.keys = [
    sshPublicKeys.teacherbearcat
    sshPublicKeys.moshi
  ];

  services.tailscale.enable = true;
  networking.firewall.allowedTCPPorts = [ 8188 ];

  virtualisation.docker = {
    enable = true;
  };

  users.users.erik.extraGroups = [ "docker" ];

  networking.hostName = "maniceraser";

  # Keep ordinary system audio at the lowest quantum tested stable on this host.
  # This is only the default: clients such as osu! may still request a different
  # latency, and the ALSA device buffer remains independently managed.
  services.pipewire.extraConfig.pipewire."92-system-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 128;
    };
  };

  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
      systemd-boot = {
        enable = true;
        windows."11" = {
          title = "Windows 11";
          efiDeviceHandle = "HD1b";
        };
      };
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "uas"
  ];

  # boot.initrd.luks.devices."cryptroot" = {
  #   keyFile = "/dev/disk/by-partuuid/951ad3ca-5d76-47a2-92a0-d10d057b9bce";
  #   keyFileSize = 4096;
  #   keyFileTimeout = 30;
  # };

  system.stateVersion = "26.05";
}
