{ ... }:

{
  programs.niri.enable = true;
  programs.dconf.enable = true;

  # nixos-hardware's 16ach6h hybrid config defaults amdgpuBusId to PCI:5:0:0,
  # but the 2nd NVMe controller sits at 0000:05:00.0 and pushed the AMD iGPU to
  # bus 6 (0000:06:00.0). Wrong bus -> X "no screens found" -> greeter hangs the
  # dual/PRIME boot. DDG (nvidia-only) specialisation is unaffected.
  hardware.nvidia.prime.amdgpuBusId = "PCI:6:0:0";

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

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
    defaultSession = "niri";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
