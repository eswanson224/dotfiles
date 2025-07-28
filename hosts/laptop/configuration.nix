{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Denver";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.erik = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.tailscale.enable = true;

  nixpkgs.config.allowUnfree = true;

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

