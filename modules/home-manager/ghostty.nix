{ ... }:

{
  programs = {
    git.enable = true;
    tmux.enable = true;
    eza.enable = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = "none";
    };
  };
}
