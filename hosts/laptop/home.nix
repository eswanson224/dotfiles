{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/home-manager
    ];

  programs.home-manager.enable = true;

  home.username = "erik";
  home.homeDirectory = "/home/erik";

  home.stateVersion = "25.05";
}
