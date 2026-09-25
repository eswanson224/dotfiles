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
          name = "SDV animation cancel";
          exact_match = true;
          application.only = [ "Stardew Valley" ];
          remap.KEY_SPACE = [
            { press = "KEY_RIGHTSHIFT"; }
            { press = "KEY_R"; }
            { press = "KEY_DELETE"; }
            { sleep = 100; }
            { release = "KEY_DELETE"; }
            { release = "KEY_R"; }
            { release = "KEY_RIGHTSHIFT"; }
          ];
        }
      ];
    };
  };
}
