{ ... }:

{
  virtualisation.docker = {
    enable = true;
  };
  users.users.erik.extraGroups = [ "docker" ];
  hardware.nvidia-container-toolkit.enable = true;
}
