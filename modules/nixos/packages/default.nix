{ pkgs, ... }:

{
  cider = import ./cider { inherit pkgs; };
  helium-browser = import ./helium-browser.nix {
    inherit (pkgs) lib fetchurl appimageTools;
  };
  # iloader = import ./iloader.nix { inherit pkgs; };
  # athas = import ./athas.nix { inherit pkgs; };
}
