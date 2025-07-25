{ pkgs, ... }:

{
  programs.dconf.enable = true;
  programs.steam.enable = true;
  users.users.erik.packages = with pkgs; [
    cider
    nixfmt-classic
    cmake
    gnumake
    libtool
    gcc15
    osu-lazer-bin
  ];
}
