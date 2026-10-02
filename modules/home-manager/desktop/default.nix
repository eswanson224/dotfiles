{ pkgs, ... }:

{
  imports = [
    ./deadbeef.nix
    ./default-apps.nix
    ./easyeffects.nix
    # ./emacs.nix
    # ./firefox
    ./gtk-theme.nix
    ./lutris.nix
    ./obs.nix
    ./obsidian.nix
    ./prismlauncher.nix
    ./vesktop.nix
    # ./vscodium.nix
    ./qalculate.nix
    ./zed.nix
  ];

  programs.nix-osu-lazer.enable = true;
  
  home.packages = with pkgs; [
    # libreoffice
    # libimobiledevice
    kdePackages.dolphin
    # kdePackages.kio-extras
  ];
}
