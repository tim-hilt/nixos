{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  # Configure Bluetooth
  hardware.bluetooth.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_TIME = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # dwm related
  services.xserver.windowManager.dwm.enable = true;
  services.autorandr.enable = true;
  services.logind.lidSwitchDocked = "suspend";

  # Commented out until I know how to properly use this with flakes
  #   nixpkgs.overlays = [
  #     (self: super: {
  #       dwm = super.dwm.overrideAttrs (_: {
  #         src = pkgs.fetchFromGitHub {
  #           owner = "tim-hilt";
  #           repo = "dwm-src";
  #           rev = "main";
  #           sha256 = "0yb9n715i569mm257c2mf0k1f4y0ayqx7mms7dvp58kz09p64303";
  #         };
  #       });
  #     })
  #   ];

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "nodeadkeys";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Commented out, because DP-Audio doesn't work with pipewire
  # security.rtkit.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [ ranger tmux ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.light.enable = true;

  users.extraUsers.tim = {
    isNormalUser = true;
    description = "Tim Hilt";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
