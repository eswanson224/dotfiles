{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = false;
    profiles = {
      erik = {
        isDefault = true;
        search.default = "ddg";
      };
    };
  };
}
