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
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
