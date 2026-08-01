{ ... }:

{
  imports = [
    ../../modules/home-manager/base
    ../../modules/home-manager/profiles/desktop
    ../../modules/home-manager/profiles/niri
  ];

  home.stateVersion = "25.05";
}
