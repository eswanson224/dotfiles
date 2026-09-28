{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = false;
    nmbd.enable = false;
    winbindd.enable = false;

    settings.global = {
      security = "user";
      "map to guest" = "Never";
      "smb ports" = "445";
    };
  };

  networking.firewall.allowedTCPPorts = [ 445 ];
}
