{ config, pkgs, ... }:

let
  # the niri-flake package the compositor actually runs — pkgs.niri is a
  # second, unrelated build (and currently broken in nixpkgs).
  niri = config.programs.niri.package;
in
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock-effects}/bin/swaylock -f";
      }
      {
        timeout = 360;
        command = "${niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${niri}/bin/niri msg action power-on-monitors";
      }
    ];
    events = {
      "before-sleep" = "${pkgs.swaylock-effects}/bin/swaylock -f";
    };
  };
}
