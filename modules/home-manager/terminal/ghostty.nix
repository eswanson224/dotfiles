{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-single-instance = true;
      window-decoration = "auto";
      shell-integration-features = "ssh-env,ssh-terminfo";
    };
  };
}
