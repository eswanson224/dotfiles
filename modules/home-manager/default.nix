{ config, pkgs, ... }:

{
  imports =
    [
      ./easyeffects.nix
      ./emacs.nix
      ./firefox
      ./ghostty.nix
      # ./hyprland
      ./i3
      ./mpv
    ];
}
