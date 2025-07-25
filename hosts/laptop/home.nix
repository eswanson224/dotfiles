{ config, pkgs, ... }:

{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  programs.home-manager.enable = true;

  imports =
    [
      ../../modules/home-manager
    ];
  
  home.stateVersion = "25.05";
}
