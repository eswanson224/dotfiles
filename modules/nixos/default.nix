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

  nixpkgs.overlays = [
    (final: prev: let
      updated-nixpkgs = import (prev.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "1d989da6d794e9487d135a48045385846f7cb0d1";
        sha256 = "03q5d9qdv5kmav5jcaz1s94dcmkkw6fdkazk5343w229iqaxxxpj";
      }) { 
        system = prev.system;
        config.allowUnfree = true;  # Add this!
      };
    in {
      osu-lazer-bin = updated-nixpkgs.osu-lazer-bin;
    })
  ];

  users.users.erik.packages = with pkgs; [
    cider
    osu-lazer-bin
  ];
}
