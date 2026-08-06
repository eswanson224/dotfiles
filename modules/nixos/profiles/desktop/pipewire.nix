{ ... }:

let
  # Apple USB-C -> 3.5mm dongle. Note this embeds the dongle's serial, so it will
  # not carry over to a replacement DAC.
  dacNode = "alsa_output.usb-Apple__Inc._USB-C_to_3.5mm_Headphone_Jack_Adapter_DWH438700CZJKLTAH-00.analog-stereo";
in
{
  security.rtkit.enable = true;

  # Without a real RLIMIT_RTPRIO, module-rt cannot call sched_setscheduler() itself.
  # It then tries the xdg-desktop-portal Realtime interface (broken here: "Could not
  # get pidns for pid N"), and only falls back to RTKit if the portal is *absent* --
  # ours answers and fails, so the data-loops ran SCHED_OTHER. Fine at a 1024 quantum,
  # crackly at 64. Verified after: pipewire FIFO 88, wireplumber and easyeffects FIFO 83.
  #
  # Both managers are needed: user@.service inherits limits from the system manager,
  # units inside the user manager from the user one. SDDM's PAM stack has no pam_limits,
  # so security.pam.loginLimits does nothing for the graphical session -- these two
  # blocks are what actually cover it, by inheritance.
  # DefaultLimitNICE is the raw rlimit (20 - nice), so 35 = nice -15.
  systemd.settings.Manager = {
    DefaultLimitRTPRIO = 95;
    DefaultLimitNICE = 35;
  };

  systemd.user.settings.Manager = {
    DefaultLimitRTPRIO = 95;
    DefaultLimitNICE = 35;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # snd-usb-audio queues URBs to cover the whole ALSA buffer, saturating at a driver
    # cap of ~576 frames (~12 ms). PipeWire's default buffer_size parked it at that cap,
    # which was the bulk of the original ~20.6 ms -- driver queue depth, not a hardware
    # floor. Shrinking buffer_size (= period-size * period-num) is what recovers it.
    # period-size 48 is exactly one full-speed USB packet (wMaxPacketSize 288 B, bInterval 1).
    #
    # This is the only setting here that buys latency, and it is device-scoped: apps see
    # a sink and never observe period-size, so it cannot upset an individual program.
    # Global *app-facing* latency policy is what broke things before -- see git history.
    #
    # Two things to know before touching it:
    #  - The graph quantum is capped at buffer_size / 2, for every app on the device.
    #  - This is a batch device, so PipeWire silently adds one period to headroom:
    #    the 48 below lands as an effective 96.
    # wireplumber.extraConfig."99-apple-dac-lowlatency" = {
    #   "monitor.alsa.rules" = [
    #     {
    #       matches = [ { "node.name" = dacNode; } ];
    #       actions.update-props = {
    #         "api.alsa.period-size" = 48;
    #         "api.alsa.period-num" = 4;
    #         "api.alsa.headroom" = 48;
    #       };
    #     }
    #   ];
    # };
  };
}
