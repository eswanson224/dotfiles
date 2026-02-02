{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    gnumake
    ispell
    libtool
    multimarkdown
    nil
    nixfmt-classic
    nodejs_24
    shellcheck
    tectonic
  ];

  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };

  services.emacs = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
