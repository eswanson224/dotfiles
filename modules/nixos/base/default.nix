{ lib, ... }:

{
  # Use the local timezone everywhere by default.  The laptop's
  # automatic-timezoned service may override this default when its location
  # changes.
  time.timeZone = lib.mkDefault "America/Denver";

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
