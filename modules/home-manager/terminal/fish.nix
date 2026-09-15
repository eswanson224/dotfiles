{ pkgs, ... }:

{
  home.packages = [
    pkgs.fishPlugins.tide
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting
      set -g fish_key_bindings fish_hybrid_key_bindings
      fish_add_path -P ~/.config/emacs/bin
      set -x EDITOR hx
      set -x PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig"
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide;
      }
    ];
  };
}
