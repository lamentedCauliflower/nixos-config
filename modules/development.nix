{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nil
    nixd
    mesa
    vulkan-tools
    gh
  ];
}
