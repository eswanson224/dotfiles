{ pkgs, ... }:

let
  sshPublicKeys = import ../ssh-public-keys.nix;
in
{
  imports = [
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ../../modules/nixos/profiles/kde
    ./hardware-configuration.nix
    ./samba.nix
    ./packages.nix
  ];

  users.users.erik.openssh.authorizedKeys.keys = [
    sshPublicKeys.teacherbearcat
    sshPublicKeys.moshi
  ];

  networking.hostName = "maniceraser";

  services.pipewire.extraConfig.pipewire."92-system-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 128;
    };
  };

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
    kernelPackages = pkgs.linuxPackages_latest;
  };

  boot.initrd.availableKernelModules = [
    "usb_storage"
    "uas"
  ];

  # Raw key partition on the USB-A drive.
  # Only reference the device here: key material must stay out of the Nix store.
  boot.initrd.luks.devices."cryptroot" = {
    keyFile = "/dev/disk/by-partuuid/909bd2a7-2d5d-4fb4-9b24-91362a9998e9";
    keyFileSize = 4096;
    # systemd initrd prompts for a password if the USB key is unavailable.
    keyFileTimeout = 10;
  };

  system.stateVersion = "26.05";
}
