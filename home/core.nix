{
  pkgs,
  username,
  ...
}:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";

    sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
      CONTEXT7_API_KEY = pkgs.lib.strings.removeSuffix "\n" (
        builtins.readFile ../secrets/CONTEXT7_API_KEY
      );
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
    profiles = {
      isaac = {
        isDefault = true;
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            # indexed at https://nur.nix-community.org/repos/rycee/
            sponsorblock
            dearrow
            return-youtube-dislikes
            tampermonkey
          ];
        };
      };
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/vnd.wav" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/opus" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";

    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "github"
        "git"
        "z"
        "sudo"
        "docker"
        "docker-compose"
        "rust"
      ];
    };
  };

  services.jellyfin-mpv-shim = {
    enable = true;
    settings = {
      player_name = "NixOS Mpv Shim";
      check_updates = false;
      notify_updates = false;
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/deep-oceanic-next.yaml";
    targets.librewolf.profileNames = [ "isaac" ];
  };

  services.kdeconnect.enable = true;

  programs.kitty.enable = true;
  programs.keepassxc.enable = true;
  programs.zed-editor.enable = true;

}
