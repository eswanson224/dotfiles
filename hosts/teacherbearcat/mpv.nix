{ lib, ... }:

{
  # Laptop playback profile. The shared mpv module remains tuned for the
  # desktop host; these values match the validated low-power benchmark on the
  # Legion's AMD iGPU.
  programs.mpv.config = {
    gpu-api = lib.mkForce "opengl";
    gpu-context = lib.mkForce "wayland";
    hwdec = lib.mkForce "vaapi";
    vaapi-device = lib.mkForce "/dev/dri/renderD129";

    # Avoid the desktop's shader chain and expensive scaling filters. These
    # defaults are intentionally simple for 1080p video on the laptop panel.
    glsl-shaders = lib.mkForce "";
    scale = lib.mkForce "bilinear";
    dscale = lib.mkForce "bilinear";
    dither = lib.mkForce "no";
    temporal-dither = lib.mkForce false;
  };
}
