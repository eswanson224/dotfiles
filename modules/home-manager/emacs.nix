{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libtool
    nixfmt-classic
    nodejs_24
    nil
    multimarkdown
    texlive.combined.scheme-medium
    shellcheck
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
