{ ... }:

{
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = ../../../wallpaper.png;
      };
    };
  };
}
