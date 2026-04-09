{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc
    ];

    config = {
      profile = "high-quality";
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "auto";
      scale-antiring = "0.6";
      dither-depth = 10;
      fs = "yes";
      keep-open = "yes";
      framedrop = "no";
      force-window = "immediate";
      cursor-autohide = 500;
      screenshot-format = "png";
      screenshot-dir = "~/Pictures/mpv";
      screenshot-template = "%{filename}-%p-%n";
      screenshot-high-bit-depth = "no";
      slang = "eng,en";
      alang = "jpn,ja";
      border = "no";
      osd-bar = "no";
      glsl-shaders = "~~/shaders/FSRCNNX_x2_16-0-4-1.glsl:~~/shaders/SSimDownscaler.glsl:~~/shaders/KrigBilateral.glsl";
    };

    extraInput = ''
      CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "Shaders Cleared"
      CTRL+1 change-list glsl-shaders toggle "~~/shaders/FSRCNNX_x2_16-0-4-1.glsl"
      CTRL+2 change-list glsl-shaders toggle "~~/shaders/SSimDownscaler.glsl"
      CTRL+3 change-list glsl-shaders toggle "~~/shaders/KrigBilateral.glsl"
    '';
  };

  home.file.".config/mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
