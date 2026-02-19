{ pkgs, ... }:

{
  home.packages = [
    pkgs.fishPlugins.tide
    pkgs.python312
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting
      set -g fish_key_bindings fish_hybrid_key_bindings
      fish_add_path -P ~/.config/emacs/bin
      set -x EDITOR hx
      set -x PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig"
      set -e fish_terminal_color_theme
    '';
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide; }
    ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
