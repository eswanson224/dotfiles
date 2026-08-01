{ pkgs, ... }:

{
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/CED05935D059254D";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=0022"
      "nofail"
    ];
  };
}
