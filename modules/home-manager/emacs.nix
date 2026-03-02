{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ispell
    multimarkdown
    nil
    nixfmt-classic
    nodejs_24
    shellcheck
    tectonic
    tinymist
    typst
    typstyle
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
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.tree-sitter-langs
      epkgs.treesit-grammars.with-all-grammars
      # (epkgs.treesit-grammars.with-grammars (grammars: [ grammars.tree-sitter-typst ]))
    ];
  };
}
