{ pkgs, ... }:

{
  imports = [
    ./deadbeef.nix
    ./easyeffects.nix
    ./emacs.nix
    ./firefox
    ./lutris.nix
    ./obs.nix
    ./obsidian.nix
    ./prismlauncher.nix
    ./vesktop.nix
    ./vscodium.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    libreoffice
    libimobiledevice
    kdePackages.dolphin
    kdePackages.kio-extras
  ];
}
