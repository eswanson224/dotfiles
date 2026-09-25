{ lib, ... }:

{
  time.timeZone = lib.mkDefault "America/Denver";

  imports = [
    ./docker.nix
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
