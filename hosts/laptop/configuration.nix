{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Denver";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erik = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # services.xserver.enable = true;
  # services.xserver.windowManager.i3.enable = true;

  services.tailscale.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    nil # nix language server
  ];

  # HACK: remove conflicting file for firefox, no clue why this happens
  system.userActivationScripts = {
    removeConflictingFiles = {
      text = ''
        rm -f /home/erik/.mozilla/firefox/dev-edition-default/search.json.mozlz4.backup
        rm -f /home/erik/.mozilla/firefox/dev-edition-default/containers.json.backup
      '';
    };
  };
  
  system.stateVersion = "24.11"; # Did you read the comment?
}

