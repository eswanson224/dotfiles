{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "Cider";
  version = "3.1.8";
  src = pkgs.requireFile {
    name = "cider-v${version}-linux-x64.AppImage";
    sha256 = "sha256-s1CMYAfDULaEyO0jZguA2bA7D7ogqRR4v/LkMD+luKw=";
    message = ''
      Cider AppImage not in nix store. Download cider-v${version}-linux-x64.AppImage, then run:
        nix-store --add-fixed sha256 cider-v${version}-linux-x64.AppImage
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
