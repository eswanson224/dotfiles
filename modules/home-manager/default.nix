{ config, pkgs, ... }:

{
  imports =
    [
      ./i3
      # ./hyprland
      ./ghostty.nix
      ./firefox.nix
    ];
}
