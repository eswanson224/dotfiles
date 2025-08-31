{ pkgs, ... }:

let
  profile = "default";
in
{
  programs.firefox = {
    enable = true;
    profiles.${profile} = {
      search = {
        force = true;
        default = "startpage";
        engines = {
          searxng = {
            name = "SearXNG";
            urls = [{ template = "http://192.168.4.23:8080/search?q={searchTerms}&language=en-US"; }];
            definedAliases = [ "@s" ];
          };
          startpage = {
            name = "Startpage";
            urls = [{
              template = "https://www.startpage.com/sp/search";
              method = "POST";
              params = [
                { name = "query"; value = "{searchTerms}"; }
                { name = "lui"; value = "english"; }
                { name = "prfe"; value = "81856aecb621ea0908790d713c61f3cd41b10b29cb2605f7c5bffc973fc648a49b621c82999bf659ebefcbb649ffa3c95353a443cf4c652921c7b832d7953100212c008cce9727253314eea4"; }
              ];
            }];
          };
        };
      };
      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "home manager";
                url = "https://home-manager-options.extranix.com/?query=&release=master";
              }
              {
                name = "nixpkgs";
                url = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages";
              }
            ];
          }
        ];
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
          firefox-color
          frankerfacez
          multi-account-containers
          old-reddit-redirect
          sponsorblock
          ublock-origin
          violentmonkey
          dearrow
        ];
      };
    };
  };
  home.file.".mozilla/firefox/${profile}/user.js".source = ./user.js;
}
