{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes"  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Denver";

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erik = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    emacs
    helix
    alacritty
    firefox
    git
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

