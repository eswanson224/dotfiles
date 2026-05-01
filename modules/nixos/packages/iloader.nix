{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "iloader";
  version = "2.2.5";
  src = pkgs.fetchurl {
    url = "https://github.com/nab138/iloader/releases/download/v${version}/iloader-linux-amd64.AppImage";
    sha256 = "sha256-19PzDGn/Sq10xzY1HDwyo02yFrfGRD+0w56OWL1vArg=";
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
