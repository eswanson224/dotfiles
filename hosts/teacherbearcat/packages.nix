{ pkgs, inputs, ... }:

# let
#   customPkgs = import ../../modules/nixos/packages { inherit pkgs; };
#   inherit (customPkgs)
#     iloader
#     onthespot
#     ;
# in
{
  environment.systemPackages = with pkgs; [
    qalculate-qt
  ];
}
