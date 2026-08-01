{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server.exports = {
    "/export" = {
      "192.168.0.103" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
        "fsid=0"
      ];
    };

    "/export/osu" = {
      "192.168.0.103" = [
        "ro"
        "sync"
        "root_squash"
        "no_subtree_check"
      ];
    };
    "/export/projects" = {
      "192.168.0.103" = [
        "rw"
        "sync"
        "root_squash"
        "no_subtree_check"
      ];
    };
  };
}
