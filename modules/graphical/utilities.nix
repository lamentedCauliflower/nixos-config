{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.pwvucontrol
    pkgs.keepassxc
    pkgs.mpv
    pkgs.qbittorrent
    pkgs.qpwgraph
    pkgs.libreoffice-qt6
    pkgs.hunspell
    pkgs.hyphenDicts.en-us
  ];

  programs.kdeconnect.enable = true;
}
