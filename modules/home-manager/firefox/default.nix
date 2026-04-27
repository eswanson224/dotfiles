{ pkgs, config, ... }:

let
  profile = "default";
in
{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.${profile} = {
      search = {
        force = true;
        default = "ddg";
        engines = {
          kagi = {
            name = "Kagi";
            urls = [{
              template = "https://kagi.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
          };
        };
      };
      containersForce = true;
      containers = {
        "1personal" = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
          name = "Personal";
        };
        "2work" = {
          color = "red";
          icon = "briefcase";
          id = 2;
          name = "Work";
        };
        "3alt" = {
          color = "purple";
          icon = "pet";
          id = 3;
          name = "Alt";
        };
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          dearrow
          firefox-color
          frankerfacez
          indie-wiki-buddy
          mal-sync
          multi-account-containers
          old-reddit-redirect
          sponsorblock
          ublock-origin
          vimium
          violentmonkey
          zotero-connector
        ];
      };
    };
  };
  home.file.".mozilla/firefox/${profile}/user.js".source = ./user.js;
}
