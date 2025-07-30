{ pkgs, ... }:

{
  home.packages = with pkgs; [
      adwaita-icon-theme
      gamemode
      mangohud
      umu-launcher
      winetricks
      wineWowPackages.waylandFull
  ];

  programs.lutris = {
    enable = true;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWowPackages.waylandFull ];
  };
}
