{ pkgs, ... }:

let
  wallpaper = "/etc/nixos/wallpaper.jpg";
in
{
  imports =
    [
      ./waybar.nix
    ];

  home.packages = with pkgs; [
    grim
    pavucontrol
    slurp
    wl-clipboard
  ];

  programs = {
    wofi.enable = true;
  };

  services = {
    dunst.enable = true;
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
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
        "HYPRCURSOR_THEME,Posy_Cursor"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_THEME,Posy_Cursor"
        "XCURSOR_SIZE,32"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
      monitor = [
        "DP-2, 1920x1080@165, 0x0, 1"
        "eDP-1, 2560x1600@60, 1920x0, 1.6"
        ", preferred, auto, 1"
      ];
      workspace = [
        "9, monitor:eDP-1, default:true"
      ];
      input = {
        accel_profile = "flat";
      };
      bind = [
        "$mod, Q, killactive,"
        "$mod, D, exec, wofi --show drun"
        "$mod, E, exec, emacsclient"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, return, exec, ghostty"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
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
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
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
