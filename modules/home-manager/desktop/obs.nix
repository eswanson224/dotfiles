{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];

    package = pkgs.symlinkJoin {
      name = "obs-studio-nvenc-fix";
      paths = [ pkgs.obs-studio ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/obs \
          --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
      '';
    };
  };
}
