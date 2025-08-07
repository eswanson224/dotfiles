{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = "none";
      gtk-single-instance = true;
    };
  };
}
