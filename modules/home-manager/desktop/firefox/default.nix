{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles."default" = {
      id = 0;
      isDefault = true;
      preConfig = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/arkenfox/user.js/bb45863/user.js";
          sha256 = "0gp3wyxljzly37qmgyfqhz48mw6pl9bhwph3yxf1g6a8j7337az4";
        }
      );
      search = {
        force = true;
        default = "ddg";
        engines = {
          kagi = {
            name = "Kagi";
            urls = [
              {
                template = "https://kagi.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
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
          old-reddit-redirect
          proton-vpn
          ublock-origin
        ];
      };
      settings = {
        "browser.nova.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = true;
        "browser.ai.control.default" = "blocked";
        "browser.uidensity" = 1;
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://dns.nextdns.io/c1241c";
        "network.trr.custom_uri" = "https://dns.nextdns.io/c1241c";
        "signon.rememberSignons" = false;
        "permissions.default.desktop-notification" = 2;
      };
    };
  };
}
