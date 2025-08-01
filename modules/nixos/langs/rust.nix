{ pkgs, ... }:

{
  users.users.erik.packages = with pkgs; [
    rustup
    pkg-config
    openssl
    openssl.dev
  ];
}
