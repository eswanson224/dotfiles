{ pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles.dev-edition-default = {
      search = {
        default = "ddg";
        engines = {
          "SearXNG" = {
            
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
        ];
      };
    };
  };
  home.file.".mozilla/firefox/dev-edition-default/user.js".source = ./user.js;
  # HACK: replace a file that causes builde error
  # home.file.".mozilla/firefox/dev-edition-default/search.json.mozlz4".force = lib.mkDefault true;
}
