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
          searxng = {
            name = "SearXNG";
            urls = [{
              template = "http://192.168.4.23:8080/search";
              method = "POST";
              params = [
                { name = "q"; value = "{searchTerms}"; }
                { name = "preferences"; value = "eJx1WMuu5LgN_ZrUxujCTDpIkEWtAmSbADNZG7JE22zLoluPqvL9-pB-Ste3F7e6dfSi-DgkrVWEjjxCeHTgwCt7s8p1SXXwAPftf3_cLGllZXBTKZKmcbIQ4XFr1RM1udpDIPsE_7jhyLvqydN7fvxb2QC3EWJP5vHf__zx5y2oFgIor_vHb7fYwwiPgHLYjU9INoaaD3PwqqNqHn_6BDdDeJ5Oiod38t1t3VWHOLNYItNNg4vga2WxcyP_f7tdmadyGky9XbuiPxP4uUZXR4x8wAqia9Fh5FO1J2vX-9dtIpZetTTzSRZ0XKd7igPM4WGgVSz_LXlbt-RHFSO67jF5iHG-GQyqsSwEuA4dq_n733_bDq43jf_lr_86wOqJBijU9fovT_2zU11dB9KobDWCQcWg0m1y2SJWTgNVYPsMdb3Y4RO6nvv1jkolgzw3poBapiy8lTMeVS6ishPLX1l06V1NSg9yCV8WZc45FSqRH59Q1y3a9X4X-Ai26TKYhmpE78lnCya2ZMW_Iogvdir2LaO28x2-KVQvHHC_MAy5bI1Cky5AtSoiU8gKDwrb_eQGLcpfppmGrVechVH3iX0jXxKbpAeI-ylTU-yIBrvufM1itbvW-m7yU7SlZFqrPCjMt-uJfacFD-y82wXslSEwyI6gUfAVe5kncsRke2eYPg2vWhBQjHKYxgB8cPwcDmAgRBWRFxAHqhfEdBX7ucQIkgv5FSzNzC-5-jSwfGiyM1hj8tfRVaRs7hIA2Vwp9Ym_QMkl512rY41q4uX8K9KM9AMnMcS5iuMUZshl_v2dCdUaT_KA3Yz8fBN7FUfmrnyZBw4kauOLLVkZ9MwQwhWr5VqPbkCl8w3znKmlA_zomYQyhIlJNbvlyUADvtuGPAfsSjTuYyLD_mPy7UQdP36yapbQCucD8pmR2HVyNTNvgReOEVbPbdOrxiv52a7sOfbBr6ZYAXgfbsqHhLuQyTJGW00U4mGyPnVMgl2rDsfOkMqoqALE8MVUYMI52AZH05zPxbFLPhMXncpexSb37LRzvuAnznm8_8DQ03ke84FXfq7EKQJm2vv4tk2d0L6W2oqV1nGyyhUnsxA9s6BVsXAzS02IcPf7izhPKj0ptw9R4p09qrIcVQdKH33BE-NrbGwOODEd_2WPc9PuKW5WKqOkZO1TGU7lBclncMVPexZSk5kD5ATGmVKNO5PSBO5Q0K5MAflxQCXkYaJMs2s2wbDTKdPflU4O8Moe59ROHl9tK8hjSg2T8XO78GdSvkgoC3C96OdLuZiv82AMxkt69tj1kf2ZirUUIxcnxIFGkMXrKt44ByydJFBH6QJchVrhC22u8As0M9bJmRh0CuE-zVyY7Y6llTGzcMqYtlBZjIDferJwwVdxhZYq-TnQkVWDugqadymfJyp2dTVmrEvDTJE46Abx-N0JojyHd6vizTm6vSEW4T-rngo1v7CZy_GADdEQPoM_E5UKFzBQ8vqKTqAXtvwFfL5VYC5Xw6KvcvWTZqmPc5Rs6zmC7NQXUfj79-__eJ-aMcmAy_3lw4k-s6ilHwDDFbn6yoYXobBkggktxfMOx6HvC2oR4HreChfHrdDFHX1q5g7GnfEmAB9Tk7PJEjx8_yA1zQuabGpWulCnjK_C-MR8mJ9o2RRL5siwF71xIMfBX4XZkZsll5-qheHTc1boGnQLfA06pntdMER4dsJ22db0fi0V5gE8ucpYyupNNy9lbc9adNkacaCRy69CC2kc7VxkrjOlrI7MdetZKBS0OHT3jjIKDOC49-Hyjvuj80i-EjipcyZai-8Fv4ErW5qFXtfGIK_RPfNB3o34Nz7zWGm4ydBqnM7CU3ZvNVpef7vui1Je0MJSC3KxiKQbCci8YtM9tANJetnfqZOXcrtwMtYNMqfxM_JClaT4qfq012cishQuxc6jMi3q4TiPxCnSZfptLeohr154OaZwaqSTjLGXU1z8nRevxVx-wVbeXVS14YWyNuyirg3_gsX77b7l8oHFViFL4RbGca72XLGSYpkT1xUpgP_VnJSKv5qTk1kVX0yz1Z9lDaO4mTTkfnHXMd2r0HN6-WKFOQux99KknfbgLDcg7KWwOJfigv-sXE997XNcabCR1dY3lfNMFwCRG5S9S5mMUOK5aOo5U7pjFuU7B4TcIScJmMyAy_i-iHtKPaEU5o3KSteJOPYCd0BGqvfdH1dhK8NFCrrVk862_rwzNaNcmsk5T3vYLzVS6Wwr9HU19UWmUAaJq096hbwp9cA9uM-JeUK1l4lZ1ZOYVEqbcTOrB2ISaC29zg8IqUkupp3-EjcKKRyWDRL306d8fYCfUsQBf1GbWTTcDfrVd3flJxe4CQt93pRLHVOeO1P6lCIP5OjUFVpmFXGubNkTx-Jbj3BUcTIDsqUo1WWRRBm76f3yjnzyYrB88tOnpHxqeXxW1aCOH-QKBY-cjUfunaujazJlveSNwyEvJSlKVy5m-xTErxj9HbOy6dLOLMD1qSt8eeQKlwkn_m3_yHN-5pts4qQYHmz0mvOMHiTUVb1-y3xxgoUjfe5LtbI68WPJL67B_QS3ceyucX2jX_rtWj4vetbOc6tUbFuja0mYWTxpPezGxTXTyuP_WFI6ng=="; }
              ];
            }];
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
          # bitwarden # HACK: uncomment when extension is fixed, older version needed atm
          dearrow
          firefox-color
          frankerfacez
          indie-wiki-buddy
          kagi-translate
          mal-sync
          multi-account-containers
          old-reddit-redirect
          sponsorblock
          ublock-origin
          vimium
          violentmonkey
        ];
      };
    };
  };
  home.file.".mozilla/firefox/${profile}/user.js".source = ./user.js;
}
