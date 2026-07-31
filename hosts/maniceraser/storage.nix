{ ... }:

{
  fileSystems."/srv" = {
    device = "/dev/disk/by-uuid/6e38a7e6-0b07-47e0-abb2-a3912f910d58";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };

  services.nfs.server.exports = {
    "/srv" = {
      "192.168.0.35" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
      ];
    };
  };
}
