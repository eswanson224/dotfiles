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
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "quarto";
        publisher = "quarto";
        version = "1.130.0";
        sha256 = "sha256-3jbQ2IemKCSD4mzNA5zxAn5pYxglJ51fyM/1kMEfApM=";
      }
    ];
  };
}
