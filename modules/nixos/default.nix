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
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.hyprlock = {};

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  catppuccin.cache.enable = true;

  nixpkgs.overlays = [
    (final: prev: let
      updated-nixpkgs = import (prev.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "a1e7c760fb4332577e76909448966c116f7b9ade";
        sha256 = "sha256-qLfn+DUpcy7gNa48uHzuLLuliG76a1BmDH1GWyyxlF0=";
      }) { 
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    in {
      osu-lazer-bin = updated-nixpkgs.osu-lazer-bin;
    })
  ];

  environment.systemPackages = with pkgs; [
    cider
    helium-browser
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    protonvpn-gui
    networkmanager-openvpn
    wireguard-tools
    gimp
    qalculate-qt
    zotero
  ];
}
