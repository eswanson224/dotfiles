_final: prev: {
  codex = prev.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "codex";
    version = "0.159.0";

    src = prev.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${finalAttrs.version}/codex-package-x86_64-unknown-linux-musl.tar.gz";
      hash = "sha256-Ndpl1+hkTijqCk1OPYwVtAxrSSNW1M8hmGx+NB+Dok4=";
    };

    nativeBuildInputs = [ prev.makeWrapper ];

    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      tar -xzf "$src" -C "$out"
      runHook postInstall
    '';

    postFixup = ''
      wrapProgram "$out/bin/codex" --prefix PATH : ${prev.lib.makeBinPath [ prev.bubblewrap ]}
    '';

    meta = prev.codex.meta // {
      platforms = [ "x86_64-linux" ];
    };
  });
}
