{ config, pkgs, ... }:

{
  imports =
    [
      # ./alacritty.nix
      ./brave.nix
      ./easyeffects.nix
      ./emacs.nix
      ./firefox
      ./hyprland
      # ./i3
      ./lutris.nix
      ./mpv
      ./thunderbird.nix
      ./vesktop.nix
      ./prismlauncher.nix
      ./terminal
    ];
}
