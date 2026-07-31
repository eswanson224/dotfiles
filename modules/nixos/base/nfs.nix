{ ... }:

{
  # Export paths and firewall rules are host-specific and belong in each
  # host's storage configuration.
  services.nfs.server.enable = true;
}
