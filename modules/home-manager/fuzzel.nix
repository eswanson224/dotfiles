{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.fuzzel = {
    enable = true;
  };
}
