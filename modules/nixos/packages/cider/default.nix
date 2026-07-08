{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "Cider";
  version = "4.0.9";
  src = pkgs.requireFile {
    name = "cider-v${version}-linux-x64.AppImage";
    sha256 = "sha256-iUHoBpP8RlUD4+5K7/14FRBhbhY8JbKG1NrOPyEFmCU=";
    message = ''
      Cider AppImage not in nix store. Download cider-v${version}-linux-x64.AppImage, then run:
        nix-store --add-fixed sha256 cider-v${version}-linux-x64.AppImage
      If it still fails, the sha256 in this module is stale. Get the correct hash with:
        nix hash file --sri cider-v${version}-linux-x64.AppImage
      and paste it into modules/nixos/packages/cider/default.nix.
    '';
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';
}
