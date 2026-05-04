{ pkgs, inputs, ... }:

let
  customPkgs = import ./packages { inherit pkgs; };
  inherit (customPkgs) cider helium-browser iloader athas;
in
{
  imports = [
    ./fonts.nix
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./ly.nix
    ./pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    cider
    helium-browser
    # iloader
    athas
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    qalculate-qt
  ];

  programs = {
    appimage.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    # niri.enable = true;
    nix-ld = {
      enable = true;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
    };
  };

  services = {
    desktopManager.plasma6.enable = true;
    usbmuxd.enable = true;
    libinput.enable = true;
    # printing.enable = true;
    tailscale = {
      enable = true;
      extraSetFlags = [
        "--operator=erik"
        "--accept-routes"
      ];
    };
  };

  # networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";
  # services.automatic-timezoned.enable = true;
  # services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   config.hyprland = {
  #     default = [ "hyprland" "gtk" ];
  #     "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
  #     "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
  #   };
  # };

  security.pam.services.hyprlock = {};

  virtualisation.docker = {
    enable = true;
  };
  
  catppuccin.cache.enable = true;
}
