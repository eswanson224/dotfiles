{ pkgs, ... }:

{
  users.users.erik.packages = with pkgs; [
    rustup
  ];
}
