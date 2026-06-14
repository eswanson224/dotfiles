{ pkgs, ... }:

# ============================================================================
# POWER-SAVING CONFIG (changed 2026-06-13)
# ----------------------------------------------------------------------------
# Tuned for laptop battery. Runs on AMD Renoir iGPU; NVIDIA dGPU stays asleep.
# Changed from defaults:
#   - vulkan-device = AMD iGPU       (was: unset -> NVIDIA dGPU)
#   - hwdec = auto-safe              (was: auto)
#   - vaapi-device = renderD128      (AMD hardware decode; was: unset)
#   - scale/dscale/cscale = bilinear (was: spline36 / catmull_rom)
#   - GLSL shader profiles REMOVED   (ravu-zoom, ArtCNN, CfL) -> moved into
#                                     opt-in `quality` profile below
#
# Full quality (NVIDIA dGPU + shaders + spline36), run on AC power:
#   mpv --profile=quality file
#
# Caveat: Renoir VAAPI has no AV1 decode -> AV1 falls back to software (CPU).
# ============================================================================

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
      vulkan-device = "AMD Radeon Graphics (RADV RENOIR)"; # [POWER-SAVE] force AMD iGPU, dGPU asleep
      autofit = "100%";
      vo = "gpu-next";
      hwdec = "auto-safe"; # [POWER-SAVE] was "auto"
      vaapi-device = "/dev/dri/renderD128"; # [POWER-SAVE] AMD hardware decode
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
      scale = "bilinear"; # [POWER-SAVE] was "spline36"
      dscale = "bilinear"; # [POWER-SAVE] was "catmull_rom"
      cscale = "bilinear"; # [POWER-SAVE] cheap chroma scaler
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
      # [POWER-SAVE] Heavy GLSL upscaling profiles (full-hd60/full-hd30/hd)
      # REMOVED from defaults. Their shaders moved here into opt-in `quality`.
      # Re-enable full quality with `mpv --profile=quality` on AC power.
      quality = {
        profile-desc = "quality";
        vulkan-device = "NVIDIA GeForce RTX 3060 Laptop GPU";
        hwdec = "auto";
        scale = "spline36";
        dscale = "catmull_rom";
        cscale = "spline36";
        glsl-shaders = "~~/shaders/ravu-zoom-ar-r3.hook:~~/shaders/CfL_Prediction.glsl";
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
