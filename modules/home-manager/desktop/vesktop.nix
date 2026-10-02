{ pkgs, ... }:

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
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
      # Native Wayland crashes during accelerated media playback in this build.
      # Use XWayland for Discord while retaining hardware acceleration.
      commandLineArgs = "--ozone-platform=x11";
    })
  ];
}
