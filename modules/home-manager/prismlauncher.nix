{ pkgs, ... }:

{
  home.packages = [
    pkgs.prismlauncher
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-jre-bin-17;
  };
}
