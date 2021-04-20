# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix 
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
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

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ranger
    tmux
    htop
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable fish. It can lead to weird bugs, if this line is not included
  programs.fish.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users= { 
    tim = {
      isNormalUser = true;
      description = "Tim Hilt";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" ];
    };
    root = {
      shell = pkgs.fish;
    };
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  
  home-manager.users.tim = { pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
      vscode
      google-chrome
      plasma-pa
      wget
      go
      rustc
      dmenu
      fd
      gnumake
      ripgrep
      hack-font
    ];
    programs = {
      neovim = {
        enable = true;
	package = pkgs.neovim-nightly;
        viAlias = true;
	vimAlias = true;
	extraConfig = ''
          inoremap jk <ESC>
          vnoremap jk <ESC>
	'';
      };
      git = {
        enable = true;
	userName = "Tim Hilt";
	userEmail = "timhilt@live.de";  # TODO: This is something, that would have to be modularized!
      };
      alacritty = {
        enable = true; # TODO: Add custom settings
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

