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
      # modmap: key -> keys held together while the input key is held
      modmap = [
        {
          name = "SDV animation cancel";
          application.only = [ "Stardew Valley" ];
          remap.KEY_SPACE = [ "KEY_RIGHTSHIFT" "KEY_R" "KEY_DELETE" ];
        }
      ];
      # keymap: sequences, launch commands, modes (AHK-style macros) go here
    };
  };

  systemd.user.services.xremap.after = [ "niri.service" ];
}
