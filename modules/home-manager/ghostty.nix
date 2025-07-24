{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = "none";
    };
  };

  programs = {
    git.enable = true;
    helix.enable = true;
    tmux.enable = true;
    eza.enable = true;
  };

  programs.fish = {
    enable = true;
    shellInit = "set -g fish_greeting";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
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
