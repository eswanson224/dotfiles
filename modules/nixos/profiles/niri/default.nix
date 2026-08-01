{ ... }:

{
  imports = [ ./xremap.nix ];
  programs.niri.enable = true;
  services.displayManager.defaultSession = "niri";
}
