{ pkgs, ... }:

let
  discord = pkgs.discord.override {
    withOpenASAR = true;
    withVencord = true;
    # Native Wayland crashes during accelerated media playback in this build.
    commandLineArgs = "--ozone-platform=x11";
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

  home.packages = [
    discord
  ];
}
