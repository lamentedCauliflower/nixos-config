{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      vencord
      heroic
      moonlight-qt
    ];
  };
}
