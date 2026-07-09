{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    inotify-tools
    libnotify
    parallel
    rsync
    unzip
  ];
}
