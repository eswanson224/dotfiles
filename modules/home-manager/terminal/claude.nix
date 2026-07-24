{ pkgs, ... }:

{
  programs.claude-code = {
    enable = true;
    plugins = [
      (pkgs.fetchFromGitHub {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "0d95a81d35a9f2d123a5e9430d1cfc43d55f1bb0";
        sha256 = "sha256-VqRHx3/4SSCnEh3cUJ/he5saIfwNhS0hOzoH/wwtU2o=";
      })
      (pkgs.fetchFromGitHub {
        owner = "forrestchang";
        repo = "andrej-karpathy-skills";
        rev = "2c606141936f1eeef17fa3043a72095b4765b9c2";
        sha256 = "sha256-4z/wRdYH7UXRzF8RJU0sw8xbpx0BW/7CBv5sVEC2knY=";
      })
    ];
  };
}
