{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      heroic
      moonlight-qt
      prismlauncher
    ];
  };

  programs.vesktop = {
    enable = true;

    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      notifyAboutUpdates = true;

      plugins = {
        ClearURLs.enabled = true;
        FixYoutubeEmbeds.enabled = true;
      };
    };

  };

}
