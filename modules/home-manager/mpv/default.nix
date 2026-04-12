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
      display-fps-override = 240;
      vo = "gpu-next";
      hwdec = "auto";
      vulkan-async-compute = true;
      vulkan-async-transfer = true;
      vulkan-queue-count = 1;
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
      deinterlace = false;
      keep-open = true;
      # Colorspace
      target-prim = "auto";
      target-trc = "auto";
      vf = "format=colorlevels=full:colormatrix=auto";
      video-output-levels = "full";
      # Dither
      dither-depth = "auto";
      temporal-dither = true;
      dither = "fruit";
      # Debanding
      deband = true;
      deband-iterations = 2;
      deband-threshold = 35;
      deband-range = 16;
      deband-grain = 0;
      # Motion Interpolation
      video-sync = "display-resample";
      hr-seek-framedrop = true;
      interpolation = true;
      tscale = "oversample";
      # Anti-Ringing
      scale-antiring = "0.6";
      # Fallback Scaling
      scale = "ewa_lanczos";
      dscale = "catmull_rom";
      correct-downscaling = true;
      linear-downscaling = true;
      sigmoid-upscaling = true;
      # Screenshots
      screenshot-format = "png";
      screenshot-dir = "~/Pictures/mpv";
      screenshot-template = "%{filename}-%p-%n";
      screenshot-high-bit-depth = "no";
      slang = "eng,en";
      alang = "jpn,ja";
      osd-bar = true;
    };

    extraInput = ''
      CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "Shaders Cleared"
    '';

    profiles = {
      full-hd60 = {
        profile-desc = "full-hd60";
        profile-cond = "((width ==1920 and height ==1080) and not p[\"video-frame-info/interlaced\"] and p[\"estimated-vf-fps\"]>=31)";
        interpolation = false;
        glsl-shaders = "~~/shaders/ravu-zoom-ar-r3.hook:~~/shaders/CfL_Prediction.glsl";
      };
      full-hd30 = {
        profile-desc = "full-hd30";
        profile-cond = "((width ==1920 and height ==1080) and not p[\"video-frame-info/interlaced\"] and p[\"estimated-vf-fps\"]<31)";
        glsl-shaders = "~~/shaders/ravu-zoom-ar-r3.hook:~~/shaders/CfL_Prediction.glsl";
      };
      hd = {
        profile-desc = "hd";
        profile-cond = "(width ==1280 and height ==720)";
        interpolation = false;
        glsl-shaders = "~~/shaders/ArtCNN_C4F16.glsl:~~/shaders/CfL_Prediction.glsl";
      };
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
