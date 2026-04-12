{ pkgs, inputs, ... }:

let
  cider = import ./cider { inherit pkgs; };
  helium-browser = import ./helium-browser.nix { inherit pkgs; };
  iloader = import ./iloader.nix { inherit pkgs; };
in
{
  imports = [
    ./fonts.nix
    ./mounts.nix
    ./steam.nix
    ./flatpak.nix
    ./ly.nix
    ./pipewire.nix
  ];

  programs = {
    appimage.enable = true;
    dconf.enable = true;
    fish.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
  };

  services.usbmuxd.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.pam.services.hyprlock = {};

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  virtualisation.docker = {
    enable = true;
  };
  
  catppuccin.cache.enable = true;

  environment.systemPackages = with pkgs; [
    cider
    helium-browser
    iloader
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    qalculate-qt
  ];
}
