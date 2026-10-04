{ config, pkgs, ... }:

{
  programs.nix-osu-lazer.enable = true;

  catppuccin.mangohud.enable = false;
  programs.mangohud = {
    enable = true;

    settings = {
      # Frame performance
      fps = true;
      frametime = true;
      frame_timing = true;

      # CPU
      cpu_stats = true;
      core_load = true;
      cpu_temp = true;
      cpu_mhz = true;
      cpu_power = true;

      # GPU
      gpu_stats = true;
      gpu_temp = true;
      gpu_core_clock = true;
      gpu_power = true;

      # Memory
      ram = true;
      vram = true;
      procmem = true;

      # Hardware issues
      throttling_status = true;

      # Benchmark logging
      output_folder = "${config.home.homeDirectory}/mangohud-logs";
      log_interval = 100;

      benchmark_percentiles = [
        97
        "AVG"
        1
        "0.1"
      ];

      toggle_logging = "Shift_L+F2";
    };
  };

  programs.lutris = {
    enable = true;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.stable ];
  };
}
