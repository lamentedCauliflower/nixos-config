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
  ];

  programs.kdeconnect.enable = true;
}
