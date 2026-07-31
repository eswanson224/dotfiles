{ ... }:

{
  imports = [
    ../catppuccin.nix
    ../terminal
    ../services
  ];

  programs.home-manager.enable = true;

  home.username = "erik";
  home.homeDirectory = "/home/erik";
}
