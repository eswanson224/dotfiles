{ pkgs, inputs, ... }:

let
  customPkgs = import ../../modules/nixos/packages { inherit pkgs; };
  inherit (customPkgs)
    iloader
    athas
    onthespot
    ;
in
{
  environment.systemPackages = with pkgs; [
    # iloader
    athas
    onthespot
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
    qalculate-qt
  ];
}
