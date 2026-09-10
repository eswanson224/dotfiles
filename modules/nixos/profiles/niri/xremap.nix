{ inputs, pkgs, ... }:

{
  imports = [ inputs.xremap.nixosModules.default ];

  services.xremap = {
    enable = true;
    # cached nixpkgs binary (wlroots variant); niri window matching works
    # via wlr-foreign-toplevel-management. If matching ever breaks, switch to
    # pkgs.xremap.override { withVariant = "niri"; } (small local build).
    package = pkgs.xremap;
    serviceMode = "user";
    userName = "erik";
    watch = true;
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

  systemd.user.services.xremap.after = [ "niri.service" ];
}
