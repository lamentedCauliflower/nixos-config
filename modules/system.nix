## Base system configuration Applied to all systems

{
  pkgs,
  username,
  ...
}:

{
  # Enable experimental Flakes and Nix CLI features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Disable NetworkManager's internal DNS resolution
  networking.networkmanager.dns = "none";

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  networking.nameservers = [
    "192.168.0.110"
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "pipewire"
    ];
  };
  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix.settings.trusted-users = [ username ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    cifs-utils
    curl
    timer
  ];
  programs.zsh.enable = true;

  # Configure neovim as the default editor
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  environment.variables.EDITOR = "nvim";

  programs.yazi.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Enable polkit for privilege escalation
  security.polkit.enable = true;

  programs.nix-ld = {
    enable = true;
  };

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    systemWide = true;
    extraConfig = {
      pipewire-pulse."20-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "psd";
          "channelmix.lfe-cutoff" = 200;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;
        };
      };
    };
  };

  # For mount.cifs, required unless domain name resolution is not needed.
  fileSystems."/mnt/media" = {
    device = "//192.168.0.14/Media";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [
        "${automount_opts}"
        "credentials=/etc/nixos/secrets/luna-smb-secrets"
        "dir_mode=0777,file_mode=0777"
        "nofail"
      ];
  };

  networking.firewall.enable = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

}
