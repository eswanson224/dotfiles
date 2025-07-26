{ pkgs, ... }:

{
  programs.dconf.enable = true;
  programs.steam.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  users.users.erik.packages = with pkgs; [
    asdf-vm
    cider
    cmake
    gcc15
    gnumake
    libtool
    nixfmt-classic
    osu-lazer-bin
    pavucontrol
  ];
}
