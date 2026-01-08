{
  ...
}:
{
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
    executable = true;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
