{ pkgs, inputs, ... }:

let
  customPkgs = import ../../modules/nixos/packages { inherit pkgs; };
  inherit (customPkgs)
    iloader
    ;
in
{
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
    llama-cpp-rocm
    iloader
  ];
}
