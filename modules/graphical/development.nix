{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    zed-editor
    qtcreator
    code-cursor
  ];
}
