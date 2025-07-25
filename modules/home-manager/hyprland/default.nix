{ ... }:

{
  programs.kitty.enable = true;
  programs.wofi.enable = true;

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
    settings = {
      "$mod" = "SUPER";
      exec-once = "hyprpaper";
      bind = [
        "$mod, D, exec, wofi --show drun"
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
    };
  };
}
