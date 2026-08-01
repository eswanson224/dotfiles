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
      modmap = [
        {
          name = "SDV animation cancel";
          application.only = [ "Stardew Valley" ];
          remap.KEY_SPACE = [
            "KEY_RIGHTSHIFT"
            "KEY_R"
            "KEY_DELETE"
          ];
        }
      ];
    };
  };

  systemd.user.services.xremap.after = [ "niri.service" ];
}
