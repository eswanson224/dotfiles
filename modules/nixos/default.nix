{ pkgs, ... }:

let
  cider = import ./cider.nix { inherit pkgs; };
in
{
  imports = [
    ./mounts.nix
    ./langs
  ];

  programs.appimage.enable = true;
  programs.dconf.enable = true;
  programs.steam.enable = true;

  programs.hyprland = {
    enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
