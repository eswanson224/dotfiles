{ pkgs, ... }:

{
  programs.steam.enable = true;
  users.users.erik.packages = with pkgs; [
    cider
  ];
}
