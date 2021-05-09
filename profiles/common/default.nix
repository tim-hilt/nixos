{ config, pkgs, ... }: {

  imports = [ ./home.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.interfaces.wwp0s20f0u6i12.useDHCP = true;

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

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "nodeadkeys";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound. Not needed, as long as pipewire works
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  nixpkgs.config.allowUnfree = true;

  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "tim" ];
      noPass = false;
      keepEnv = true;
    }];
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [
    ranger
    tmux
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs = { light.enable = true; };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
    (self: super: {
      dwm = super.dwm.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "tim-hilt";
          repo = "dwm-src";
          rev = "main";
          sha256 = "0yb9n715i569mm257c2mf0k1f4y0ayqx7mms7dvp58kz09p64303";
        };
      });
    })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    tim = {
      isNormalUser = true;
      description = "Tim Hilt";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "video" ];
    };
    root = { shell = pkgs.fish; };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
