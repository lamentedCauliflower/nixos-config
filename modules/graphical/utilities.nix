{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    pwvucontrol
    keepassxc
    mpv
    qbittorrent
    qpwgraph

    libreoffice-qt6
    hunspell
    hyphenDicts.en-us

  ];

  programs.kdeconnect.enable = true;
}
