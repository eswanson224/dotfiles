{ pkgs, lib, ... }:

let
  customPkgs = import ../../packages { inherit pkgs; };
  inherit (customPkgs) helium-browser cider;
in
{
  # helium-browser: some tools (e.g. via) require a chromium-based browser.
  # cider: only included once its AppImage has actually been added to the
  # store (see modules/nixos/packages/cider). Warn instead of failing the
  # build when it's missing, since add-fixed is a manual per-machine step.
  environment.systemPackages = [
    helium-browser
  ]
  ++ (
    if cider.available then
      [ cider.package ]
    else
      lib.warn
        "cider: AppImage not in the nix store, skipping (see modules/nixos/packages/cider/default.nix for the nix-store --add-fixed step)"
        [ ]
  );
}
