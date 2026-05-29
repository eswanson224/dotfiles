{ ... }:

{
  imports = [
    ./syncthing.nix
    # HACK: kanshi disabled, broken with hyprland wlr-output-management events.
    # Replaced by socket2 listener in hyprland/default.nix.
    # ./kanshi.nix
  ];
}
