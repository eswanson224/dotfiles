{ pkgs, ... }:

let
  # niri has no action to insert a fresh workspace between two existing ones, so
  # reproduce the overview "drop into the gap" behaviour: move the window to the
  # monitor's trailing empty workspace (focus follows), then slide that workspace
  # up to sit directly below the origin.
  moveWindowToNewWorkspaceDown = pkgs.writeShellScript "niri-move-window-new-ws-down" ''
    set -euo pipefail
    ws=$(niri msg -j workspaces)
    read -r output cur < <(printf '%s' "$ws" \
      | ${pkgs.jq}/bin/jq -r '.[] | select(.is_focused) | "\(.output) \(.idx)"')
    [ -n "''${output:-}" ] || exit 0
    maxidx=$(printf '%s' "$ws" \
      | ${pkgs.jq}/bin/jq -r --arg o "$output" '[.[] | select(.output==$o) | .idx] | max')
    niri msg action move-window-to-workspace "$maxidx"
    niri msg action move-workspace-to-index "$((cur + 1))"
  '';
in
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

  home.packages = [ pkgs.brightnessctl ];

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

      # Clicking a mako notification should focus the sending app. The
      # activation token that reaches niri carries a serial niri rejects,
      # so it only marks the window urgent. Honor those tokens anyway.
      # Tradeoff: apps can steal focus with self-made tokens.
      debug.honor-xdg-activation-with-invalid-serial = [ ];

      # 1920x1200@165.019
      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1200;
          refresh = 165.019;
        };
        scale = 1.25;
      };

      clipboard = {
        disable-primary = true;
      };

      layout = {
        default-column-width = {
          proportion = 0.5;
        };

        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 0.75; }
        ];

        focus-ring = {
          active.color = "#cba6f7"; # catppuccin mocha mauve
          inactive.color = "#313244"; # catppuccin mocha surface0
        };
      };

      overview.backdrop-color = "#11111b"; # catppuccin mocha crust

      hotkey-overlay.skip-at-startup = true;

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

        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = [ ];
        };
        "Mod+Shift+N" = {
          hotkey-overlay.title = "Move window to new workspace below";
          action.spawn = "${moveWindowToNewWorkspaceDown}";
        };

        "Mod+Ctrl+H".action.focus-monitor-left = [ ];
        "Mod+Ctrl+J".action.focus-monitor-down = [ ];
        "Mod+Ctrl+K".action.focus-monitor-up = [ ];
        "Mod+Ctrl+L".action.focus-monitor-right = [ ];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

        "Mod+Ctrl+U".action.move-workspace-down = [ ];
        "Mod+Ctrl+I".action.move-workspace-up = [ ];

        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [ ];
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [ ];
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [ ];
        };
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-column-width-back = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];
        "Mod+Ctrl+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];

        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
        };
        "XF86AudioPause" = {
          allow-when-locked = true;
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = [
            "playerctl"
            "next"
          ];
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = [
            "playerctl"
            "previous"
          ];
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
        };

        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };
        "Mod+Shift+E".action.quit = [ ];
      };
    };
  };
}
