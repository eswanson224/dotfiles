{ ... }:

{
  programs.vesktop = {
    enable = true;
    settings = {
      minimizeToTray = false;
      tray = false;
    };
    vencord = {
      settings = {
        plugins = {
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          FakeNitro.enabled = true;
          CallTimer.enabled = true;
          VolumeBooster.enabled = true;
          BlurNSFW.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          NoReplyMention.enabled = true;
        };
      };
    };
  };
}
