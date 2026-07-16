{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gamemode
    mangohud
  ];

  programs.lutris = {
    enable = true;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.stable ];
  };
}
