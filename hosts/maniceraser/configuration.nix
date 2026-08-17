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

  networking.hostName = "maniceraser";

  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
  };

  system.stateVersion = "26.05";
}
