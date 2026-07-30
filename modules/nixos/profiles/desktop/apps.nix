{ pkgs, ... }:

let
  customPkgs = import ../../packages { inherit pkgs; };
  inherit (customPkgs) helium-browser cider;
in
{
  # helium-browser: some tools (e.g. via) require a chromium-based browser.
  environment.systemPackages = [
    helium-browser
    cider
  ];
}
