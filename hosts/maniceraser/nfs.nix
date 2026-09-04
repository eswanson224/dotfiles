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

      "100.91.120.77" = [
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

      "100.91.120.77" = [
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

      "100.91.120.77" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "mountpoint"
      ];
    };
  };
}
