{ ... }:

{
  imports = [
    ../../modules/home-manager/base
    ../../modules/home-manager/profiles/desktop
    ../../modules/home-manager/profiles/niri
    ./mpv.nix
  ];

  programs.fish.functions.power-mode = ''
    if test (count $argv) -ne 1
      echo "Usage: power-mode {performance|balanced|power-saver}" >&2
      return 2
    end

    switch $argv[1]
      case performance balanced power-saver
        sudo tlp $argv[1]
      case '*'
        echo "Usage: power-mode {performance|balanced|power-saver}" >&2
        return 2
    end
  '';

  home.stateVersion = "25.05";
}
