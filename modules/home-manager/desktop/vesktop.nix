{ pkgs, ... }:

let
  discord = pkgs.discord.override {
    withOpenASAR = true;
    withVencord = true;
    # Native Wayland crashes during accelerated media playback in this build.
    commandLineArgs = "--ozone-platform=x11";
  };
  # Discord's remotely updated frontend downloads OpenH264 2.7.0 and removes
  # 2.5.1, but desktop core 1.0.166 (and upstream 1.0.167) still loads 2.5.1.
  # Keep the runtime download and cleanup consistent with the native bridge.
  # Remove this workaround when upstream aligns those components.
  discordWithMatchingCodec = discord.override {
    unwrappedDiscord = discord.unwrappedDiscord.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.asar ];
      postFixup = (old.postFixup or "") + ''
        core="$out/opt/Discord/modules/discord_desktop_core/core.asar"
        unpacked="$TMPDIR/discord-core-openh264"
        asar extract "$core" "$unpacked"
        ${pkgs.python3}/bin/python3 ${./discord-openh264.py} "$unpacked/mainScreenPreload.js"
        asar pack "$unpacked" "$core"
      '';
    });
  };
in
{
  # programs.vesktop = {
  #   enable = true;
  #   settings = {
  #     minimizeToTray = false;
  #     tray = true;
  #     hardwareAcceleration = true;
  #     hardwareVideoAcceleration = true;
  #     arRPC = true;
  #     enableSplashScreen = false;
  #   };
  #   vencord = {
  #     settings = {
  #       autoUpdate = true;
  #       autoUpdateNotification = false;
  #       plugins = {
  #         MessageLogger = {
  #           enabled = true;
  #           ignoreSelf = true;
  #         };
  #         TextReplace = {
  #           enabled = true;
  #           regexRules = [
  #             {
  #               find = "(?<=https:\/\/)x(?=.com\/.+)";
  #               replace = "fixupx";
  #               onlyIfIncludes = "";
  #             }
  #           ];
  #         };
  #         FakeNitro.enabled = true;
  #         CallTimer.enabled = true;
  #         VolumeBooster.enabled = true;
  #         BlurNSFW.enabled = true;
  #         FixYoutubeEmbeds.enabled = true;
  #         NoReplyMention.enabled = true;
  #         Dearrow.enabled = true;
  #         YoutubeAdblock.enabled = true;
  #         NoTypingAnimation.enabled = true;
  #       };
  #     };
  #   };
  # };
  # Discord rewrites settings.json, so install the package without the
  # programs.discord module's managed settings file and backup collisions.
  home.packages = [
    discordWithMatchingCodec
  ];
}
