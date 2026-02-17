# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    limine = {
      enable = true;
      extraEntries = ''
        /Windows Boot Manager
            comment: Chainload the EFI loader on the second NVMe
            protocol: efi
            path: guid(a3d03aeb-5139-44bf-8b82-0e27ee09f133):/EFI/Microsoft/Boot/bootmgfw.efi
      '';
      force = true;
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
    grub.enable = false;

  };

  networking.hostName = "cleo-nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  services.pipewire.extraConfig.pipewire."30-5_1-to-4_1-Mixer" =
    import ../../pipewire/pipewire-5_1-to-4_1.nix;

  hardware.xpadneo.enable = true;
}
