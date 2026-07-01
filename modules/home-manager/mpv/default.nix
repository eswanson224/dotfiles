{ pkgs, ... }:

{
  catppuccin.mpv.enable = false;

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc
    ];

    config = {
      # General
      gpu-api = "vulkan";
      autofit = "100%";
      vo = "gpu-next";
      hwdec = "auto";
      vd-lavc-dr = true;
      reset-on-next-file = "audio-delay,mute,pause,speed,sub-delay,video-aspect-override,video-pan-x,video-pan-y,video-rotate,video-zoom,volume";
      framedrop = false;
      # UI
      border = false;
      msg-color = true;
      term-osd-bar = true;
      force-window = "immediate";
      cursor-autohide = 500;
      fs = true;
      # Playback
      keep-open = true;
      # Dither
      dither-depth = "auto";
      temporal-dither = true;
      dither = "fruit";
      # Motion Interpolation
      hr-seek-framedrop = true;
      # Anti-Ringing
      scale-antiring = "0.6";
      scale = "spline36";
      dscale = "catmull_rom";
      # Shaders
      glsl-shaders = "~~/shaders/ravu-zoom-ar-r3.hook:~~/shaders/CfL_Prediction.glsl";
      # Screenshots
      screenshot-format = "png";
      screenshot-dir = "~/Pictures/mpv";
      screenshot-template = "%{filename}-%p-%n";
      screenshot-high-bit-depth = true;
      slang = "eng,en";
      alang = "jpn,ja";
      osd-bar = true;
    };

    # extraInput = ''
    #   CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "Shaders Cleared"
    # '';

    profiles = {
      "protocol.http" = {
        hls-bitrate = "max";
        cache = true;
        cache-pause = false;
      };
      "protocol.https" = {
        profile = "protocol.http";
      };
      "protocol.ytdl" = {
        profile = "protocol.http";
      };
    };
  };

  home.file.".config/mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
