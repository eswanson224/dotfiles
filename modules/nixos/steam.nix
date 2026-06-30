{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      gamescope
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    # capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    inotify-tools
    libnotify
    parallel
    rsync
    unzip
  ];
}
