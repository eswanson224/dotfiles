{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "cider";
  version = "3.0.2";
  src = ./cider-v3.0.2-linux-x64.AppImage;

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
