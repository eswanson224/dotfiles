{ pkgs, ... }:

{
  home.packages = [
    pkgs.fishPlugins.tide
  ];

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting
      fish_add_path -P ~/.config/emacs/bin
      set -x PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig"
    '';
    functions = {
      y = ''
      	set tmp (mktemp -t "yazi-cwd.XXXXXX")
      	yazi $argv --cwd-file="$tmp"
      	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      		builtin cd -- "$cwd"
      	end
      	rm -f -- "$tmp"
      '';
     };
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
