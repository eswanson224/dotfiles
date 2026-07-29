{ lib, ... }:

{
  imports = [
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ./hardware-configuration.nix
  ];
  # ++ lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;

  users.users.erik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ];
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  hardware.i2c.enable = true;

  networking.hostName = "maniceraser";

  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "26.05";
}
