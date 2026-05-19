{ inputs, ... }:

{
  imports = [ inputs.xremap.nixosModules.default ];

  services.xremap = {
    enable = true;
    withKDE = true;
    serviceMode = "user";
    userName = "erik";
    config = {
      keymap = [
        {
          name = "example firefox binds";
          application = {
            "only" = "firefox";
          };
          remap = {
            "CapsLock" = "Esc";
          };
        }
      ];
    };
  };
}
