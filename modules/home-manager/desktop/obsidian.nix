{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # electron 41.9.1 wasm regression freezes obsidian on launch;
    # drop the override once nixpkgs electron is >= 41.10.2
    (obsidian.override { electron = electron_42; })
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
