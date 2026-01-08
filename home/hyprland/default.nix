{
  ...
}:
{
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
    executable = true;
  };
  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Helps with Wayland/NVIDIA flickering or mapping issues
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

}
