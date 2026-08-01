{ ... }:

{
  programs.dconf.enable = true;

  services.xserver.enable = true;

  systemd.user.units = {
    "drkonqi-coredump-launcher.socket".enable = false;
    "drkonqi-coredump-cleanup.timer".enable = false;
    "drkonqi-sentry-postman.path".enable = false;
    "drkonqi-sentry-postman.timer".enable = false;
  };
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
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
