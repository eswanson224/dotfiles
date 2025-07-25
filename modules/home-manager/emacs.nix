{ ... }:

{
  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
  };
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
