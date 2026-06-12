{ ... }:

{
  services = {
    mako = {
      enable = true;
    };
  };
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

      outputs."eDP-1" = {
        mode = {
          width = 2560;
          height = 1600;
          refresh = 60.0;
        };
        scale = 1.6;
      };

      binds = {
        "Mod+Return".action.spawn = "ghostty";
        "Mod+D".action.spawn-sh = "rofi -show drun";
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
