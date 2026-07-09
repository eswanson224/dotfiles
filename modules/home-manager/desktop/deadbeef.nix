{ pkgs, ... }:

let
  ddbDiscordPlugin = pkgs.fetchzip {
    url = "https://github.com/kuba160/ddb_discord_presence/releases/download/v1.7/linux-7550631.zip";
    sha256 = "sha256-X+G5DpI3RUg8Dn0gwXqhI4pVfx7seBf06iptU4TG6HA=";
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "deadbeef-wrapped";
      paths = [
        (pkgs.deadbeef-with-plugins.override {
          plugins = with pkgs.deadbeefPlugins; [
            musical-spectrum
          ];
        })
      ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/deadbeef" \
          --set PIPEWIRE_LATENCY "512/48000"
      '';
    })
  ];

  home.file.".local/lib/deadbeef" = {
    source = ddbDiscordPlugin;
    recursive = true;
  };
}
