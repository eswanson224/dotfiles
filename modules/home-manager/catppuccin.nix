{ ... }:

let
  enable = true;
in
{
  catppuccin = {
    inherit enable;
    autoEnable = enable;
    flavor = "mocha";
    hyprland.enable = false;
  };
}
