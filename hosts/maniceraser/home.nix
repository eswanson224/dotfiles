{ ... }:

{
  imports = [
    ../../modules/home-manager/base
    ../../modules/home-manager/profiles/desktop
  ];

  programs.home-manager.enable = true;

  home.username = "erik";
  home.homeDirectory = "/home/erik";

  home.stateVersion = "26.05";
}
