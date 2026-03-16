{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
    thunar
  ];

  imports = [
    # ./anki.nix
    # ./brave.nix
    ./easyeffects.nix
    ./emacs.nix
    ./lutris.nix
    ./obs.nix
    ./obsidian.nix
    ./prismlauncher.nix
    ./vesktop.nix
    ./vscodium.nix
    ./zathura.nix
  ];
}
