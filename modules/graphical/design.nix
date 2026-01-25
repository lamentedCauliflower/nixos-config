{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.freecad
    pkgs.blender
    pkgs.gimp
    pkgs.inkscape-with-extensions
    pkgs.krita
  ];
}
