{ config, pkgs, ... }:

{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  programs.home-manager.enable = true;

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

  home.file.".config/i3/config".source = ./i3/config;
  
  home.stateVersion = "25.05";
}
