{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      feishin
      beets
      picard
      tidal-hifi
      tidal-dl
    ];
  };
}
