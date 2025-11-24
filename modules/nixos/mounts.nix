{ pkgs, ... }:

{
  users.users.erik.packages = with pkgs; [
    cifs-utils
  ];

  fileSystems."/mnt/media" = {
    device = "//192.168.4.23/media";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  fileSystems."/mnt/erik" = {
    device = "//192.168.4.23/erik";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  # fileSystems."/mnt/windows" = {
  #   device = "/dev/disk/by-uuid/F4523CC1523C89FE";
  #   fsType = "ntfs";
  # };
}
