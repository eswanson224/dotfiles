{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
  ];
  imports = [
    ./anki.nix
    ./brave.nix
    ./easyeffects.nix
    ./lutris.nix
    ./obs.nix
    ./obsidian.nix
    ./prismlauncher.nix
    ./vesktop.nix
    ./zathura.nix
  ];
}
