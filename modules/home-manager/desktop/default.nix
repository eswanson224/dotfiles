{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
    libimobiledevice
    kdePackages.dolphin
    kdePackages.kio-extras
  ];

  imports = [
    # ./anki.nix
    # ./brave.nix
    ./easyeffects.nix
    ./element.nix
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
