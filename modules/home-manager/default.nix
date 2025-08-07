{ config, pkgs, ... }:

{
  imports =
    [
      ./brave.nix
      ./easyeffects.nix
      ./emacs.nix
      ./firefox
      ./hyprland
      ./lutris.nix
      ./mpv
      ./thunderbird.nix
      ./vesktop.nix
      ./prismlauncher.nix
      ./terminal
    ];
}
