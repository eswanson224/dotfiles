{ pkgs, lib, ... }:

let
  # HACK: replacement for kanshi until https://github.com/hyprwm/Hyprland/pull/14547 fixed
  # upstream. Toggles eDP-1 based on DP-2 presence via hyprctl.
  monitorHotplug = pkgs.writeShellScript "monitor-hotplug" ''
    export PATH=${
      lib.makeBinPath (
        with pkgs;
        [
          socat
          jq
          hyprland
          coreutils
          util-linux
        ]
      )
    }:$PATH
    log=/tmp/monitor-hotplug.log
    exec >>"$log" 2>&1
    exec 9>>/tmp/monitor-hotplug.lock
    flock -n 9 || { echo "[$(date)] already running, exit"; exit 0; }
    echo "[$(date)] start pid=$$"

    sock="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

    dock() {
      echo "[$(date)] dock"
      hyprctl keyword monitor "DP-2, 2560x1440@240, 0x0, 1"
      hyprctl keyword monitor "eDP-1, disable"
    }

    undock() {
      echo "[$(date)] undock"
      sleep 0.3
      hyprctl reload
      sleep 0.1
      hyprctl keyword monitor "eDP-1, 2560x1600@60, 0x0, 1.6"
    }

    # At startup, eDP-1 already enabled by hyprland catchall — set scale
    # without reload (reload causes screen flash). Only dock if DP-2 already
    # present.
    if hyprctl monitors -j | jq -e '.[] | select(.name=="DP-2")' >/dev/null; then
      dock
    else
      hyprctl keyword monitor "eDP-1, 2560x1600@60, 0x0, 1.6"
    fi

    socat -U - "UNIX-CONNECT:$sock" | while read -r event; do
      echo "[$(date)] event: $event"
      case "$event" in
        monitoradded*DP-2*) dock ;;
        monitorremoved*DP-2*) undock ;;
      esac
    done
  '';
in
{
  imports = [
    ./hyprlock.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    grimblast
    pavucontrol
    wl-clipboard
  ];

  programs = {
    rofi.enable = true;
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "eDP-1";
            path = "/home/erik/nixconf/wallpaper.png";
          }
          {
            monitor = "DP-2";
            path = "/home/erik/nixconf/oled.png";
          }
          {
            monitor = "";
            path = "/home/erik/nixconf/oled.png";
          }
        ];
      };
    };
    playerctld.enable = true;
  };

  systemd.user.services.hyprpaper.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];

  home.file.".icons/Posy_Cursor" = {
    source = ./Posy_Cursor;
    recursive = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "hyprlang";
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
      source = [ "${pkgs.catppuccin-hyprland}/share/themes/catppuccin-hyprland-themes/mocha.conf" ];
      general = {
        "col.active_border" = "$mauve";
        "col.inactive_border" = "$crust";
        layout = "master";
        allow_tearing = true;
      };
      input = {
        accel_profile = "flat";
        touchpad = {
          tap-to-click = false;
          clickfinger_behavior = true;
          scroll_factor = 0.3;
        };
      };
      device = {
        name = "endgame-gear-endgame-gear-op1-8k-gaming-mouse";
        sensitivity = -0.5;
      };
      misc = {
        vrr = 0;
      };
      # HACK: plasma login manager cursor would stick around on hyprland when
      # dual gpu and this was set to the default of auto
      cursor = {
        no_hardware_cursors = false;
      };
      render = {
        cm_enabled = false;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
        "gsettings set org.gnome.desktop.interface cursor-theme 'Posy_Cursor'"
        # HACK: kanshi broken with hyprland wlr-output-management (misses
        # unplug events). Listen to hyprland socket2 + drive hyprctl directly.
        "${monitorHotplug}"
      ];
      env = [
        "DEFAULT_TARGET_DIR,Pictures/screenshots"
        "HYPRCURSOR_THEME,Posy_Cursor"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_THEME,Posy_Cursor"
        "XCURSOR_SIZE,32"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        # "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      ];
      monitor = [
        # "DP-2, 2560x1440@240, 0x0, 1"
        "eDP-1, 2560x1600@60, auto, 1.6"
        ", preferred, auto, 1"
      ];
      bind = [
        "$mod, Q, killactive,"
        "$mod, D, exec, rofi -show drun"
        "CTRL ALT, L, exec, hyprlock"
        "$mod, return, exec, ghostty"
        ", Print, exec, grimblast -fn copysave area"
        "$mod, V, togglefloating,"
        "$mod, F, fullscreenstate, 2, 0"
        "$mod SHIFT, F, fullscreen,"
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
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
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
      bindm = [
        "$mod, mouse:272, movewindow"
      ];
      workspace = [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      windowrule = [
        "match:class steam_app_0, immediate yes"
        "border_size 0, match:float 0, match:workspace w[tv1]"
        "rounding 0, match:float 0, match:workspace w[tv1]"
        "border_size 0, match:float 0, match:workspace f[1]"
        "rounding 0, match:float 0, match:workspace f[1]"
      ];
      animation = [
        "global, 0"
      ];
    };
  };
}
