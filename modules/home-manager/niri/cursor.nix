{ ... }:

{
  home.file.".icons/Posy_Cursor" = {
    source = ./Posy_Cursor;
    recursive = true;
  };

  # niri-flake sets XCURSOR_THEME/XCURSOR_SIZE for niri and spawned clients
  # from this — the niri-native equivalent of hyprland's old manual
  # HYPRCURSOR_THEME/exec-once gsettings hack.
  programs.niri.settings.cursor = {
    theme = "Posy_Cursor";
    size = 32;
  };

  # package = null (default) is correct: GTK's xcursor lookup scans
  # ~/.icons, so a vendored (non-packaged) theme just needs the name.
  gtk.enable = true;
  gtk.cursorTheme = {
    name = "Posy_Cursor";
    size = 32;
  };
}
