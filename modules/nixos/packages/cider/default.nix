{ pkgs, ... }:

let
  pname = "cider";
  version = "4.0.9.1";

  src = pkgs.fetchurl {
    url = "https://repo.cider.sh/apt/pool/main/cider-v${version}-linux-x64.deb";
    hash = "sha256-MsA6lK3PsyOEx938FgJFx8l9oqwoM3FzIK5goF73lTs=";
  };

  unwrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit pname version src;

    nativeBuildInputs = [ pkgs.dpkg ];
    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      dpkg-deb --fsys-tarfile "$src" \
        | tar --extract --directory "$out" --no-same-owner --no-same-permissions
      runHook postInstall
    '';
  };

  fhs = pkgs.appimageTools.defaultFhsEnvArgs;
in
pkgs.buildFHSEnv (
  fhs
  // {
    name = pname;
    targetPkgs = p: (fhs.targetPkgs p) ++ [ unwrapped ];
    runScript = "${unwrapped}/usr/lib/cider/Cider";

    extraInstallCommands = ''
      install -m 444 -D \
        ${unwrapped}/usr/share/applications/cider.desktop \
        $out/share/applications/Cider.desktop
      install -m 444 -D \
        ${unwrapped}/usr/share/pixmaps/cider.png \
        $out/share/pixmaps/cider.png
    '';

    meta = {
      description = "Apple Music client";
      homepage = "https://cider.sh";
      license = pkgs.lib.licenses.unfree;
      mainProgram = pname;
      platforms = [ "x86_64-linux" ];
    };
  }
)
