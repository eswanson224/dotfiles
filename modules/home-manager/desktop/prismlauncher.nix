{ pkgs, ... }:

{
  programs.prismlauncher = {
    enable = true;
    settings = {
      ApplicationTheme = "Breeze";
      IconTheme = "breeze_dark";
      LaunchMaximized = true;
      AutomaticJavaDownload = false;
      EnableFeralGamemode = true;
      JvmArgs = "-XX:+UseZGC -XX:+ParallelRefProcEnabled -XX:+DisableExplicitGC";
      MaxMemAlloc = 16384;
      MinMemAlloc = 1024;
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.graalvmPackages.graalvm-ce;
  };
}
