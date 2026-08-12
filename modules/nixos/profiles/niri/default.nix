{ niriEnabled, ... }:

{
  imports = [ ./xremap.nix ];
  programs.niri.enable = niriEnabled;
  services.displayManager.defaultSession = if niriEnabled then "niri" else null;
}
