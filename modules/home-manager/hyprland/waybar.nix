{ ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      modules-left =
        [
          "hyprland/workspaces"
          "custom/media"
        ];
      modules-center =
        [
          "hyprland/window"
        ];
      modules-right =
        [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "custom/gpu-temp"
          "backlight"
          "battery"
          "clock"
          "tray"
          "custom/power"
        ];
      tray.spacing = 10;
      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = {
        format = "{}% ";
      };
      temperature = {
        hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
      "custom/gpu-temp" = {
        format = "{text}°C";
        exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
        interval = 10;
      };
    };
    style = ./style.css;
  };
}
