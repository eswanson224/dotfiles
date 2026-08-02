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

  # services.hardware.openrgb = {
  #   enable = true;
  #   motherboard = "amd";
  # };

  # hardware.i2c.enable = true;

  networking.hostName = "maniceraser";

  # boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };

  system.stateVersion = "26.05";
}
