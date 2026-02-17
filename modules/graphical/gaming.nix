{
  pkgs,
  millennium,
  ...
}:

{
  nixpkgs.overlays = [ millennium.overlays.default ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.millennium-steam;
    gamescopeSession = {
      enable = true;
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;
}
