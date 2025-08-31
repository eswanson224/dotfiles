{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    gnumake
    libtool
    multimarkdown
    nil
    nixfmt-classic
    nodejs_24
    shellcheck
    texlive.combined.scheme-medium
  ];

  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
