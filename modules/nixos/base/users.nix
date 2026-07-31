{ ... }:

{
  users.users.erik = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ];
  };
}
