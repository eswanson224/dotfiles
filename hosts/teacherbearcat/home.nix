{ ... }:

{
  imports = [
    ../../modules/home-manager/base
    ../../modules/home-manager/profiles/desktop
    ../../modules/home-manager/profiles/niri
    ./mpv.nix
  ];

  home.stateVersion = "25.05";
}
