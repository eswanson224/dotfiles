{ pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-icon-theme
    gamemode
    mangohud
    umu-launcher
    winetricks
    wineWow64Packages.stable
  ];

  programs.lutris = {
    enable = true;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.stable ];
  };
}
