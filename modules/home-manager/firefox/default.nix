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
        default = "kagi";
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
              {
                name = "nixos wiki";
                url = "https://wiki.nixos.org";
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
