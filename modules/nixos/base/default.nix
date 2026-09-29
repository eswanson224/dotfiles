{ lib, ... }:

{
  time.timeZone = lib.mkDefault "America/Denver";

  imports = [
    ./docker.nix
    ./samba.nix
    ./nix.nix
    ./shell.nix
    ./ssh.nix
    ./users.nix
    ./utils.nix
    ./networking.nix
  ];
}
