{ ... }:

{
  services.samba.settings.global = {
    "hosts allow" = "192.168.0.103";
    "hosts deny" = "ALL";
  };

  services.samba.settings = {
    osu = {
      path = "/export/osu";
      "read only" = "yes";
      "guest ok" = "no";
      "valid users" = "erik";
    };

    projects = {
      path = "/export/projects";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = "erik";
    };
  };
}
