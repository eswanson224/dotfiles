{ pkgs, ... }:

let
  cider = import ./cider.nix { inherit pkgs; };
in
{
  imports = [
    ./langs
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
  ];

  programs.appimage.enable = true;
  programs.dconf.enable = true;

  programs.hyprland = {
    enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.displayManager.ly.enable = true;

  users.users.erik.packages = with pkgs; [
    cider
    osu-lazer-bin
  ];
}
