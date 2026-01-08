{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    pwvucontrol
    keepassxc
  ];
}
