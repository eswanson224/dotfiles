{ pkgs, ... }:

let
  lutris-ldap-fix = (pkgs.lutris.override {
    # Intercept buildFHSEnv to modify target packages
    buildFHSEnv = args: pkgs.buildFHSEnv (args // {
      multiPkgs = envPkgs:
        let
          # Fetch original package list
          originalPkgs = args.multiPkgs envPkgs;

          # Disable tests for openldap
          customLdap = envPkgs.openldap.overrideAttrs (_: { doCheck = false; });
        in
        # Replace broken openldap with the custom one
        builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
    });
  });
in
{
  home.packages = with pkgs; [
    adwaita-icon-theme
    gamemode
    mangohud
    umu-launcher
    winetricks
    wineWow64Packages.stable
  ];


  programs.lutris = {
    enable = true;
    package = lutris-ldap-fix;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = [ pkgs.wineWow64Packages.stable ];
  };
}
