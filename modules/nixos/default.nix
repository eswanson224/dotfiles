{ pkgs, ... }:

{
  programs.dconf.enable = true;
  programs.steam.enable = true;
  users.users.erik.packages = with pkgs; [
    cider
  ];
}
