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
      };
      containers = {
        personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
          name = "Personal";
        };
        work = {
          color = "red";
          icon = "briefcase";
          id = 2;
          name = "Work";
        };
        alt = {
          color = "purple";
          icon = "pet";
          id = 3;
          name = "Alt";
        };
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          multi-account-containers
          violentmonkey
        ];
      };
    };
  };
  home.file.".mozilla/firefox/dev-edition-default/user.js".source = ./user.js;
}
