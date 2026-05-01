{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "Cider";
  version = "3.1.2";
  src = pkgs.fetchurl {
    url = "file://${./cider-v3.1.2-linux-x64.AppImage}";
    sha256 = "sha256-1syFQAvx4OdM2y03nP31r+YapH69ijd8XhEp4WxNxOo=";
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
