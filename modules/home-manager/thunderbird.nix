{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles = {
      erik = {
        isDefault = true;
        search.default = "ddg";
      };
    };
  };
}
