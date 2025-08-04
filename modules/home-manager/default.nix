{ config, pkgs, ... }:

{
  imports =
    [
      # ./alacritty.nix
      ./brave.nix
      ./easyeffects.nix
      ./emacs.nix
      ./firefox
      ./ghostty.nix
      ./hyprland
      # ./i3
      ./lutris.nix
      ./mpv
      ./thunderbird.nix
      ./vesktop.nix
    ];
}
