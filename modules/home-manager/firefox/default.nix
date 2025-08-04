{ pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles.dev-edition-default = {
      search = {
        default = "ddg";
        engines = {
          searxng = {
            name = "SearXNG";
            urls = [{ template = "http://192.168.4.23:8080/search?q={searchTerms}&language=en-US"; }];
            definedAliases = [ "@s" ];
          };
        };
        force = true;
      };
      bookmarks = {
        settings = [
          # {
          #   name = "home manager";
          #   url = "https://home-manager-options.extranix.com/?query=&release=master";
          # }
          # {
          #   name = "nixpkgs";
          #   url = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages";
          # }
            {
              name = "wikipedia";
              tags = [ "wiki" ];
              keyword = "wiki";
              url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
            }
            {
              name = "kernel.org";
              url = "https://www.kernel.org";
            }
            "separator"
            {
              name = "Nix sites";
              toolbar = true;
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = [ "wiki" "nix" ];
                  url = "https://wiki.nixos.org/";
                }
              ];
            }
        ];
        force = true;
      };
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
      containersForce = true;
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          multi-account-containers
          violentmonkey
          old-reddit-redirect
          sponsorblock
        ];
      };
    };
  };
  home.file.".mozilla/firefox/dev-edition-default/user.js".source = ./user.js;
}
