{
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    kitty
    hyprlauncher
    hypridle
    hyprpicker
    hyprpolkitagent
    hyprsunset
    hyprls
    hyprlock
    hyprpaper
    hyprcursor
    playerctl
    quickshell
  ];

  qt.enable = true;

  services.displayManager.ly.enable = true;
}
