{ pkgs, ... }:

let
  inherit (pkgs) lib;
  py = pkgs.python3.pkgs;

  # --- vendored deps not in nixpkgs ---

  # pymp4 + pywidevine were written for construct 2.8's API (reversed Const
  # signature, etc.); nixpkgs ships 2.10 which is incompatible. Vendor 2.8.8.
  # Nothing else in the final env pulls construct, so there's no clash.
  # Patch the py3.10+ collections.abc move so runtime paths work too.
  construct288 = py.buildPythonPackage rec {
    pname = "construct";
    version = "2.8.8";
    pyproject = true;
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0ms13i8l0lalnas0r0qcv0d8202imklc6dxpck7mplbggwabi10v";
    };
    build-system = [ py.setuptools ];
    postPatch = ''
      substituteInPlace construct/core.py \
        --replace-quiet 'collections.Sequence' 'collections.abc.Sequence' \
        --replace-quiet 'collections.Mapping' 'collections.abc.Mapping'
    '';
    doCheck = false;
    pythonImportsCheck = [ "construct" ];
  };

  pymp4 = py.buildPythonPackage rec {
    pname = "pymp4";
    version = "1.4.0";
    pyproject = true;
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "1dbvnx995lc5fphg6jwfjd364wc086jn5a4aqcs3s54a59rpg7mw";
    };
    build-system = [ py.poetry-core ];
    dependencies = [ construct288 ];
    pythonRelaxDeps = [ "construct" ];
    doCheck = false;
    pythonImportsCheck = [ "pymp4" ];
  };

  # pywidevine: DRM helper. Version pins (protobuf ^6, etc.) relaxed against nixpkgs.
  pywidevine = py.buildPythonPackage rec {
    pname = "pywidevine";
    version = "1.9.0";
    pyproject = true;
    src = pkgs.fetchPypi {
      inherit pname version;
      sha256 = "1cji1sm3dif753p7ii68s3fzq7qqngph04zb2d45lz3rzpsxlhk7";
    };
    build-system = [ py.poetry-core ];
    dependencies =
      (with py; [
        protobuf
        pycryptodome
        click
        requests
        unidecode
        pyyaml
      ])
      ++ [
        pymp4
        construct288
      ];
    pythonRelaxDeps = true;
    doCheck = false;
    pythonImportsCheck = [ "pywidevine" ];
  };

  # librespot: OnTheSpot pins the justin025 fork, not the nixpkgs upstream.
  librespot = py.buildPythonPackage {
    pname = "librespot";
    version = "0.0.10-unstable-2025";
    pyproject = true;
    src = pkgs.fetchFromGitHub {
      # update-git-srcs: skip — pinned to a specific fork rev OnTheSpot depends on
      owner = "justin025";
      repo = "librespot-python";
      rev = "4e70bc40b7a64f522a90c9e9026326ffa9d1580c";
      sha256 = "09s2r54n8vs240vl2vn1r272wkdww2hx4fmp94sw20i29y4a329g";
    };
    build-system = [ py.setuptools ];
    dependencies = with py; [
      defusedxml
      protobuf
      pycryptodomex
      pyogg
      requests
      websocket-client
      zeroconf
    ];
    pythonRelaxDeps = true;
    doCheck = false;
    # _pb2 files predate protobuf 7; pure-python impl parses them (also set at
    # runtime via the onthespot wrapper). Needed here so importsCheck passes.
    env.PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION = "python";
    pythonImportsCheck = [ "librespot" ];
  };

in
py.buildPythonApplication rec {
  pname = "onthespot";
  version = "1.8.0beta4";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "ots-downloader";
    repo = "onthespot";
    rev = "v${version}";
    sha256 = "0n2gyd5mh75yv6mfazv2lny43x9qy1nchjlcd6i61im9lmn11svd";
  };

  build-system = [ py.setuptools ];

  # The tag's pyproject [project] table overrides setup.cfg and omits the
  # console_scripts, so no entry points get built. Re-add them.
  postPatch = ''
    printf '\n[project.scripts]\nonthespot-cli = "onthespot.cli:main"\nonthespot-web = "onthespot.web:main"\nonthespot-gui = "onthespot.gui:main"\n' >> pyproject.toml
  '';

  dependencies = with py; [
    flask
    flask-login
    m3u8
    music-tag
    mutagen
    pillow
    pyqt6
    pyqt6-sip
    requests
    urllib3
    yt-dlp
    librespot
    pywidevine
  ];

  pythonRelaxDeps = true;
  dontCheckRuntimeDeps = true; # requirements.txt carries a git URL for librespot

  # PyQt6 GUI: wrap with Qt env, plus ffmpeg on PATH and the pure-python
  # protobuf impl (librespot's generated _pb2 modules vs protobuf 7).
  dontWrapQtApps = true;
  nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
  buildInputs = [ pkgs.qt6.qtbase ];
  preFixup = ''
    makeWrapperArgs+=(
      "''${qtWrapperArgs[@]}"
      --prefix PATH : ${lib.makeBinPath [ pkgs.ffmpeg ]}
      --set PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION python
    )
  '';

  postInstall = ''
    ln -s $out/bin/onthespot-gui $out/bin/onthespot

    install -Dm644 src/onthespot/resources/org.onthespot.OnTheSpot.desktop \
      $out/share/applications/org.onthespot.OnTheSpot.desktop
    substituteInPlace $out/share/applications/org.onthespot.OnTheSpot.desktop \
      --replace-fail 'Exec=python3 -m onthespot' 'Exec=onthespot'

    install -Dm644 src/onthespot/resources/icons/onthespot.png \
      $out/share/pixmaps/onthespot.png
  '';

  meta = {
    description = "Music/media downloader (Spotify, etc.) — GUI";
    homepage = "https://github.com/ots-downloader/onthespot";
    license = lib.licenses.gpl2Only;
    mainProgram = "onthespot";
    platforms = lib.platforms.linux;
  };
}
