{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "athas";
  version = "0.4.7";
  src = pkgs.fetchurl {
    url = "https://github.com/athasdev/athas/releases/download/v${version}/Athas_${version}_amd64.AppImage";
    sha256 = "sha256-33N/bYeytih+xRXUIb/kzNFt5ssFDl66w03NJE9ppgA=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/Athas.desktop -t $out/share/applications/${pname}.desktop
      cp -r ${contents}/usr/share/icons $out/share
    '';
}
