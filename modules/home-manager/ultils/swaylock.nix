{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      indicator = true;
      screenshots = true;
      effect-blur = "7x5";
      fade-in = 0.2;
    };
  };
}
