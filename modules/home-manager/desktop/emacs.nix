{ pkgs, ... }:

{
  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    # extraPackages = epkgs: [
    #   epkgs.vterm
    # ];
  };
}
