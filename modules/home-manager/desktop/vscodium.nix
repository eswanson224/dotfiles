{ pkgs, ... }:

with pkgs;
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      reditorsupport.r
      reditorsupport.r-syntax
      myriad-dreamin.tinymist
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      mkhl.direnv
    ];
  };
}
