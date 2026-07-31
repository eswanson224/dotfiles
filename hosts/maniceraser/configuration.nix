{ lib, ... }:

let
  sshPublicKeys = import ../ssh-public-keys.nix;
in
{
  imports = [
    ../../modules/nixos/base
    ../../modules/nixos/profiles/desktop
    ./hardware-configuration.nix
    ./storage.nix
  ];

  users.users.erik.openssh.authorizedKeys.keys = [ sshPublicKeys.teacherbearcat ];

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
    timeout = 1;
  };

  system.stateVersion = "26.05";
}
