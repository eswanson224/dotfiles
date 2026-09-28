{ ... }:

{
  services.samba.settings.global = {
    "hosts allow" = "192.168.0.82 100.91.120.77 100.70.223.2";
    "hosts deny" = "ALL";
  };

  services.samba.settings = {
    srv = {
      path = "/export/srv";
      "read only" = "yes";
      "guest ok" = "no";
      "valid users" = "erik";
    };

    media = {
      path = "/export/media";
      "read only" = "yes";
      "guest ok" = "no";
      "valid users" = "erik";
    };
  };
}
