{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "Monospace";
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          path = "/etc/nixos/wallpaper.jpg";
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 40";
          outline_thickness = 3;
          inner_color = "rgb(f2f2f2)";
          outer_color = "rgba(a5a5a5ee)";
          font_color = "rgb(595959)";
          fade_on_empty = false;
          rounding = 20;
          font_family = "$font";
          placeholder_text = "<i>whats da password</i>";
          fail_text = "$PAMFAIL";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME12";
          font_size = 40;
          font_family = "$font";
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
