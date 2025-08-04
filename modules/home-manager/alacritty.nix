{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
  };

  programs = {
    btop = {
      enable = true;
      package = pkgs.btop-cuda;
    };
    helix.enable = true;
    tmux.enable = true;
    eza.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "eswanson224";
    userEmail = "eswanson224@proton.me";
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting
      fish_add_path -P ~/.config/emacs/bin
      set -x PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig"
    '';
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
