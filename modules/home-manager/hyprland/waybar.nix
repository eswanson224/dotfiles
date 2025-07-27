{ ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      modules-left =
        [
          "hyprland/workspaces"
          "hyprland/mode"
          "hyprland/scratchpad"
          "custom/media"
        ];
      modules-center =
        [
          "hyprland/window"
        ];
    };
    style = ./style.css;
  };
}
