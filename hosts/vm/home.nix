{ config, pkgs, ... }:

{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  programs.home-manager.enable = true;

  imports =
    [
      ../../modules/home-manager
    ];

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-devedition;
  
  home.stateVersion = "25.05";
}
