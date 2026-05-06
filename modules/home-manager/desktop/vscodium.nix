{ pkgs, ... }:

with pkgs;
{
  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium-fhs;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      myriad-dreamin.tinymist
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      mkhl.direnv
      ms-python.python
      ms-pyright.pyright
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
    ];
  };
}
