{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["erik"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
