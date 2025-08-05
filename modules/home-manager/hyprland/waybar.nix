{ ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      modules-left =
        [
          "hyprland/workspaces"
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
          # "temperature"
          # "custom/gpu-temp"
          "backlight"
          "battery"
          "clock"
          "tray"
          "custom/power"
        ];
      tray.spacing = 10;
      clock = {
        format = "{:%a, %b %d  %r}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        interval = 1;
      };
      cpu = {
        format = "CPU {usage}%";
        tooltip = false;
      };
      memory = {
        format = "RAM {}%";
      };
      temperature = {
        hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        format = "CPU {temperatureC}°C";
      };
      "custom/gpu-temp" = {
        format = "GPU {text}°C";
        exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
        interval = 10;
      };
    };
    style = ./style.css;
  };
}
