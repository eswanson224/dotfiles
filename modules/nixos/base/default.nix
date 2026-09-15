{ lib, ... }:

{
  time.timeZone = lib.mkDefault "America/Denver";

  imports = [
    ./nfs.nix
    ./nix.nix
    ./overlays.nix
    ./shell.nix
    ./ssh.nix
    ./users.nix
    ./utils.nix
    ./networking.nix
  ];
}
