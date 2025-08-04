{ pkgs, ... }:

{
  imports =
    [
      ./waybar.nix
    ];

  home.packages = with pkgs; [
    pavucontrol
    grim
    slurp
    wl-clipboard
  ];

  programs = {
    wofi.enable = true;
  };

  services = {
    dunst.enable = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = "/etc/nixos/mia.jpg";
      wallpaper = ", /etc/nixos/mia.jpg";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "hyprpaper"
        "waybar"
      ];
      # https://github.com/ValveSoftware/gamescope/issues/1825#issuecomment-2883202415
      "debug:full_cm_proto" = "true";
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];
      monitor = "DP-2, 1920x1080@165, 0x0, 1";
      input = {
        accel_profile = "flat";
      };
      bind = [
        "$mod, Q, killactive,"
        "$mod, D, exec, wofi --show drun"
        "$mod, E, exec, emacsclient"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreen,"
        "$mod, return, exec, alacritty"
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
