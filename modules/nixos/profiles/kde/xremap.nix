{ inputs, pkgs, ... }:

# let
#   # Use the upstream KDE-enabled binary instead of compiling xremap locally.
#   xremap-kde = pkgs.stdenvNoCC.mkDerivation {
#     pname = "xremap";
#     version = "0.15.7";

#     src = pkgs.fetchzip {
#       url = "https://github.com/xremap/xremap/releases/download/v0.15.7/xremap-linux-x86_64-kde.zip";
#       hash = "sha256-KkPfkbtzVzXc0EV4uNwU3RInw0vTfl8ShnhvhTl6Fss=";
#       stripRoot = false;
#     };

#     installPhase = ''
#       install -Dm755 xremap $out/bin/xremap
#     '';
#   };
# in {
{
  imports = [ inputs.xremap.nixosModules.default ];

  services.xremap = {
    enable = true;
    withKDE = true;
    # package = xremap-kde;
    serviceMode = "user";
    userName = "erik";
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
}
