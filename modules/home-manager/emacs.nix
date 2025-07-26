{ ... }:

{
  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
