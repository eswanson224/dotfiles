{ ... }:

{
  imports = [
    ../services/mako.nix
    ../services/swayidle.nix
    ../services/wpaperd.nix
    ../utils/fuzzel.nix
    ../utils/nautilus.nix
    ../utils/swaylock.nix
    ../utils/wl-clipboard.nix
    ../utils/xwayland-satellite.nix
    ./cursor.nix
    ./waybar.nix
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
        mouse = {
          accel-profile = "flat";
          accel-speed = -0.5;
        };
      };

      # Match hyprland's GL setup. __GLX_VENDOR_LIBRARY_NAME only affects GLX
      # (X11) and is ignored by Wayland EGL apps -> harmless in both GPU modes.
      # Do NOT set __EGL_VENDOR_LIBRARY_FILENAMES: it hard-overrides glvnd to
      # the nvidia EGL vendor only, hiding mesa. In hybrid mode niri composites
      # on the iGPU, so nvidia EGL can't make a context -> GL apps (ghostty)
      # fail with "unable to acquire an opengl context for rendering".
      environment = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };

      # Direct scanout (exclusive fullscreen, integer-scaled output) flips the
      # app buffer straight to the display synced to vblank -> caps fps to
      # refresh. Disable so the render loop runs uncapped (osu input latency).
      # Tradeoff: fullscreen video composites instead of scanning out (power).
      # debug.disable-direct-scanout = [ ];

      # Clicking a mako notification should focus the sending app. The
      # activation token that reaches niri carries a serial niri rejects,
      # so it only marks the window urgent. Honor those tokens anyway.
      # Tradeoff: apps can steal focus with self-made tokens.
      debug.honor-xdg-activation-with-invalid-serial = [ ];

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
        { argv = [ "waybar" ]; }
      ];

      clipboard = {
        disable-primary = true;
      };

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+D".action.spawn = "fuzzel";
        "Super+Alt+L".action.spawn = "swaylock";
        "Mod+Q".action.close-window = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];

        "Mod+H".action.focus-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+J".action.focus-window-or-workspace-down = [ ];
        "Mod+K".action.focus-window-or-workspace-up = [ ];

        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];

        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+Shift+Home".action.move-column-to-first = [ ];
        "Mod+Shift+End".action.move-column-to-last = [ ];

        "Mod+U".action.focus-workspace-down = [ ];
        "Mod+I".action.focus-workspace-up = [ ];
        "Mod+Shift+U".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+I".action.move-column-to-workspace-up = [ ];

        "Mod+Shift+P".action.power-off-monitors = [ ];

        "Print".action.screenshot = [ ];
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];

        "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
    };
  };
}
