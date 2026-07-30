{
  config,
  lib,
  pkgs,
  ...
}:

let
  easyeffectsConfig = ./easyeffects;
  installEasyeffectsConfig = pkgs.writeShellScript "install-easyeffects-config" ''
    config_dir=${lib.escapeShellArg "${config.xdg.configHome}/easyeffects"}

    ${pkgs.coreutils}/bin/mkdir -p "$config_dir"
    ${pkgs.coreutils}/bin/cp --no-preserve=mode,ownership --recursive \
      ${lib.escapeShellArg "${easyeffectsConfig}/."} "$config_dir/"
    ${pkgs.coreutils}/bin/chmod -R u+w "$config_dir"
  '';
in
{
  services.easyeffects.enable = true;

  # EasyEffects writes its Qt settings in place, so these cannot be regular
  # Home Manager symlinks into the read-only Nix store. Copy them immediately
  # before startup instead, while the service is stopped.
  systemd.user.services.easyeffects.Service.ExecStartPre = installEasyeffectsConfig;

  # Restart the service when the tracked settings change.
  systemd.user.services.easyeffects.Unit.X-Restart-Triggers = [ "${easyeffectsConfig}" ];
}
