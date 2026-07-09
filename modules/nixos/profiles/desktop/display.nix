{ ... }:

{
  programs.niri.enable = true;
  programs.dconf.enable = true;

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.usbmuxd.enable = true;
  services.libinput.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      # X11 greeter: the kwin wayland greeter races niri for DRM state on
      # NVIDIA hybrid at handoff, corrupting scanout on a random output
      # (see sddm/sddm#2142)
      wayland.enable = false;
      settings.General.InputMethod = "";
    };
    defaultSession = "niri";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
