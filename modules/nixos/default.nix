{ pkgs, inputs, ... }:

let
  customPkgs = import ./packages { inherit pkgs; };
  inherit (customPkgs) cider helium-browser iloader athas onthespot;
in
{
  imports = [
    ./fonts.nix
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./pipewire.nix
    ./xremap.nix
  ];

  environment.systemPackages = with pkgs; [
    cider
    helium-browser
    # iloader
    athas
    onthespot
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    qalculate-qt
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs = {
    appimage.enable = true;
    dconf.enable = true;
    fish.enable = true;
    gamemode.enable = true;
    niri.enable = true;
    nix-ld = {
      enable = true;
      libraries = pkgs.steam-run.args.multiPkgs pkgs;
    };
  };

  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    usbmuxd.enable = true;
    libinput.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        # X11 greeter: the kwin wayland greeter races niri for DRM state on
        # NVIDIA hybrid at handoff, corrupting scanout on a random output
        # (see sddm/sddm#2142)
        wayland.enable = false;
        settings.General.InputMethod = "";
      };
      defaultSession = "niri";
    };
    tailscale = {
      enable = true;
      extraSetFlags = [
        "--operator=erik"
        "--accept-routes"
      ];
    };
  };

  networking.networkmanager.enable = true;
  # WiFi radio powersave stalls large CDN downloads (nix cache, discord cdn)
  # after lock/display-off; small requests survive. Independent of platform profile.
  networking.networkmanager.wifi.powersave = false;

  # time.timeZone = "America/Denver";
  services.automatic-timezoned.enable = true;
  services.geoclue2.geoProviderUrl = "https://api.beacondb.net/v1/geolocate";

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    cache.enable = true;
  };
}
