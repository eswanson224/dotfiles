{ ... }:

{
  imports =
  [
    ./waybar.nix
    ../ultils/fuzzel.nix
    ../services/mako.nix
    ../ultils/xwayland-satellite.nix
    ../services/wpaperd.nix
  ];

  programs.niri = {
    settings = {
      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          accel-profile = "flat";
          click-method = "clickfinger";
          dwt = true;
          natural-scroll = false;
          tap = false;
        };
        mouse.accel-profile = "flat";
      };

      # nvidia DDG (dGPU-only): Mesa has no HW driver -> GL apps (osu-lazer)
      # fall back to llvmpipe (CPU software render). Force the nvidia GL/EGL
      # stack so they use the dGPU. Only correct in dGPU-only; scope per-app
      # if niri is ever run in dual-GPU mode (would force everything off iGPU).
      environment = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
      };

      # Direct scanout (exclusive fullscreen, integer-scaled output) flips the
      # app buffer straight to the display synced to vblank -> caps fps to
      # refresh. Disable so the render loop runs uncapped (osu input latency).
      # Tradeoff: fullscreen video composites instead of scanning out (power).
      debug.disable-direct-scanout = [ ];

      outputs."eDP-1" = {
        mode = {
          width = 2560;
          height = 1600;
          refresh = 60.008;
        };
        scale = 1.6;
      };

      outputs."DP-2" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 239.972;
        };
        scale = 1.0;
      };

      spawn-at-startup = [
        { argv = ["waybar"]; }
      ];

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Q".action.close-window = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];

        "Mod+H".action.focus-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];

        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];
        "Mod+Shift+J".action.move-window-down = [ ];
        "Mod+Shift+K".action.move-window-up = [ ];

        "Print".action.screenshot = [ ];

        "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
  };
}
