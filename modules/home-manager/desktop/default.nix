{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
    libimobiledevice
    kdePackages.dolphin
    kdePackages.kio-extras
    (deadbeef-with-plugins.override {
      plugins = with deadbeefPlugins; [
        musical-spectrum
      ];
    })
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
