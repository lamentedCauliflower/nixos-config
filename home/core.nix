{ pkgs, username, ... }:
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
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "gh"
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

  programs.kitty.enable = true;
  programs.keepassxc.enable = true;
  programs.zed-editor.enable = true;

}
