{ pkgs, ... }:

{
  programs.appimage.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };
}
