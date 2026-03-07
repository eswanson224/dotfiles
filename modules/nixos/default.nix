{ lib, pkgs, inputs, ... }:

let
  cider = import ./cider { inherit pkgs; };
  helium-browser = import ./helium-browser.nix { inherit pkgs; };
in
{
  imports = [
    # ./docker.nix
    ./fonts.nix
    ./langs
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./ly.nix
    # ./niri.nix
    ./pipewire.nix
  ];

  programs = {
    appimage.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.hyprlock = {};

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  catppuccin.cache.enable = true;

  environment.systemPackages = with pkgs; [
    cider
    helium-browser
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    protonvpn-gui
    networkmanager-openvpn
    wireguard-tools
    gimp
    qalculate-qt
    zotero
  ];
}
