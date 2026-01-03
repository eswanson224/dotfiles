{ pkgs, ... }:

let
  cider = import ./cider { inherit pkgs; };
in
{
  imports = [
    ./docker.nix
    ./langs
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./ly.nix
    ./niri.nix
    ./pipewire.nix
  ];

  programs = {
    appimage.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.hyprlock = {};

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  users.users.erik.packages = with pkgs; [
    cider
    osu-lazer-bin
    protonvpn-gui
    networkmanager-openvpn
    wireguard-tools
  ];
}
