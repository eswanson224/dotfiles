{ pkgs, ... }:

{
  home.packages = [
    pkgs.prismlauncher
  ];

  programs.java = {
    enable = true;
    package = pkgs.graalvmPackages.graalvm-ce;
  };
}
