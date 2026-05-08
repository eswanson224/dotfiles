{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-single-instance = true;
      window-decoration = "auto";
    };
  };
}
