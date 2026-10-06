{ ... }:

{
  imports = [ ./xremap.nix ];
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    defaultSession = "plasma";
    sddm = {
      enable = true;
      # Keep the greeter on X11 for reliable handoff to the desktop session.
      wayland.enable = false;
      settings.General.InputMethod = "";
    };
  };
}
