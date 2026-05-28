{ ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "DP-2";
            mode = "2560x1440@240Hz";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "mobile";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "2560x1600@60Hz";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
