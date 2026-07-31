{ ... }:

{
  imports = [
    ./nfs.nix
    ./nix.nix
    ./overlays.nix
    ./ssh.nix
    ./users.nix
    ./utils.nix
    ./networking.nix
  ];
}
