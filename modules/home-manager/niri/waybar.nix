{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    nerd-fonts.fantasque-sans-mono
  ];

  catppuccin.waybar.mode = "createLink";

  programs.waybar = {
    enable = true;
    settings.main = {
      layer = "top";
      position = "top";
      modules-left = [ "niri/workspaces" ];
      modules-center = [ ];
      modules-right = [
        "group/sysinfo"
        "group/net"
        "tray"
      ];
      "group/net" = {
        orientation = "horizontal";
        modules = [
          "network"
        ];
      };
      "group/sysinfo" = {
        orientation = "horizontal";
        modules = [
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
        ];
      };
      network = {
        format-wifi = "  {essid} {signalStrength}%";
        format-ethernet = "󰈁 {ipaddr}";
        format-disconnected = "󰤭 off";
        tooltip-format = "{ifname} via {gwaddr}";
        on-click = "nm-connection-editor";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "";
        format-icons = {
          default = [ "" "" " " ];
        };
        on-click = "pavucontrol";
      };
      backlight = {
        format = "{icon}";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
      };
      battery = {
        format = "{capacity}% {icon}";
        format-full = "{capacity}% {icon}";
        format-charging = "{capacity}% 󰃨";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = [ "" "" "" "" "" ];
      };
      clock = {
        timezone = "America/Denver";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%a, %b %d}";
        format = "{:%I:%M %p}";
      };
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          default = "";
        };
      };
    };

    style = ./style.css;
  };
}
