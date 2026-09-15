{ pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.erik.shell = pkgs.fish;
}
