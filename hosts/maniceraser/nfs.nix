{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server.exports = {
    "/export/srv" = {
      "192.168.0.35" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "mountpoint"
      ];
    };
  };
}
