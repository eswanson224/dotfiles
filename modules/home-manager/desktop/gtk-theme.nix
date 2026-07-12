{ pkgs, ... }:

{
  # adw-gtk3 is GTK3-only; GTK4/libadwaita apps ignore gtk-theme-name and
  # go dark via the color-scheme key below instead.
  gtk.theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  gtk.gtk4.theme = null;

  # On Wayland GDK reads org/gnome/desktop/interface from dconf, which
  # overrides settings.ini — the hm gtk module mirrors gtk-theme/icon/cursor
  # into dconf on every switch, but not color-scheme. Without this, stale
  # Plasma-era dconf values win (deadbeef went light when a Dolphin launch
  # dbus-activated kded6 and it clobbered the leftover gtk.css/dconf theming).
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
