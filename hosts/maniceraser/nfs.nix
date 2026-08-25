{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server.exports = {
    "/export" = {
      "192.168.0.82" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "fsid=0"
      ];
    };

    "/export/srv" = {
      "192.168.0.82" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "mountpoint"
      ];
    };

    "/export/media" = {
      "192.168.0.82" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "mountpoint"
      ];
    };
  };
}
