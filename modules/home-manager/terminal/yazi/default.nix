{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };
    initLua = ./init.lua;
  };
}
