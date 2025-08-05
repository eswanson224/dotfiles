{ pkgs, ... }:

{
  users.users.erik.packages = with pkgs; [
    cmake
    gcc15
    gnumake
    glib
  ];
}
