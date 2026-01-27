{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
  ];
  # programs.obsidian = {
  #   enable = true;
  #   # vaults.master = {
  #   #   enable = true;
  #   #   target = "Documents/master";
  #   #   settings = {
  #   #   };
  #   # };
  # };
}
