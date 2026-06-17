{ pkgs, ... }:

# niri-flake routes the portal FileChooser to xdg-desktop-portal-gnome, which
# dbus-activates nautilus to draw the actual dialog. Without nautilus's dbus
# service on the session bus the portal accepts the request but no window
# appears, so file pickers silently fail (firefox uploads/downloads, etc).
# Installing it here registers org.gnome.Nautilus / org.freedesktop.FileManager1
# under the home-manager profile share, which is on XDG_DATA_DIRS, so the
# session bus can activate it.
{
  home.packages = [
    pkgs.nautilus
  ];
}
