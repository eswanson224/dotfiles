{ pkgs, ... }:

let
  cider = import ./cider.nix { inherit pkgs; };
in
{
  imports = [
    ./docker.nix
    ./langs
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./ly.nix
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

  users.users.erik.packages = with pkgs; [
    cider
    osu-lazer-bin
  ];
}
