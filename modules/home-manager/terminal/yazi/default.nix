{ pkgs, ... }:

{
  nixpkgs.overlays = [ (final: prev: { _7zz = pkgs._7zz-rar; } ) ];
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    initLua = ./init.lua;
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };
  };
}
