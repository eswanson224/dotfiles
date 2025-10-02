{ pkgs, ... }:

let
  wallpaper = "/etc/nixos/wallpaper.png";
in
{
  imports =
    [
      ./hyprlock.nix
      ./waybar.nix
    ];

  home.packages = with pkgs; [
    brightnessctl
    grim
    hyprpicker
    hyprshot
    pavucontrol
    rofimoji
    slurp
    wl-clipboard
  ];

  programs = {
    rofi.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          follow = "mouse";
        };
      };
    };
    playerctld.enable = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = wallpaper;
      wallpaper = ", ${wallpaper}";
    };
  };

  home.file.".icons/Posy_Cursor" = {
    source = ./Posy_Cursor;
    recursive = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    submaps.resize.settings = {
      binde = [
       ", L, resizeactive, 10 0"
       ", H, resizeactive, -10 0"
       ", K, resizeactive, 0 -10"
       ", J, resizeactive, 0 10"
      ];
      bind = [
        ", escape, submap, reset"
      ];
    };
    settings = {
      general = {
        "col.active_border" = "$mauve";
        "col.inactive_border" = "$crust";
        layout = "master";
      };
      "$mod" = "SUPER";
      exec-once = [
        # HACK idk why using "hyprpaper" causes wallpaper to not load on initial ly signin
        "systemctl --user enable --now hyprpaper.service"
        "waybar"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Posy_Cursor'"
      ];
      # https://github.com/ValveSoftware/gamescope/issues/1825#issuecomment-2883202415
      "debug:full_cm_proto" = "true";
      env = [
        "HYPRSHOT_DIR,Pictures/screenshots"
        "HYPRCURSOR_THEME,Posy_Cursor"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_THEME,Posy_Cursor"
        "XCURSOR_SIZE,32"
        "GDK_SCALE,1"
        "GRIM_DEFAULT_DIR,Pictures/screenshots"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      ];
      monitor = [
        "DP-2, 1920x1080@165, 0x0, 1"
        "eDP-1, 2560x1600@60, auto, 1.6"
        ", preferred, auto, 1"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
      workspace = [
        "9, monitor:eDP-1, default:true"
      ];
      input = {
        accel_profile = "flat";
        touchpad = {
          tap-to-click = false;
          clickfinger_behavior = true;
          scroll_factor = 0.3;
        };
      };
      bind = [
        "$mod, Q, killactive,"
        "$mod, D, exec, rofi -show drun"
        "CTRL ALT, L, exec, hyprlock"
        "$mod, period, exec, rofimoji"
        "$mod, return, exec, ghostty"
        ", Print, exec, hyprshot -m region --freeze"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, C, pin"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        "$mod, R, submap, resize"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
      ];
      windowrule = [
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
      ];
    };
  };
}
