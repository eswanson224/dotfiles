{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/base
    ../../modules/home-manager/profiles/desktop
  ];

  programs.btop.package = pkgs.btop-rocm;

  home.stateVersion = "26.05";
}
