# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let vimPlugsFromSource = (import ./nvim/nvim-plugins.nix) pkgs;
in {
  imports = [ <home-manager/nixos> ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

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

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (pkgs.libsForQt5.callPackage ({ mkDerivation }: mkDerivation) { } rec {
      name = "hello";
      version = "Hidden Hedgehog";
      src = pkgs.fetchFromGitHub {
        owner = "n4n0GH";
        repo = "hello";
        rev = "master";
        sha256 = "1898swsq07rwnd3gdff7v153hzyv9k1hf5817z7a7gr8rphbn3km";
      };
      nativeBuildInputs = with pkgs; [ cmake ];
      buildInputs = with pkgs; [
        extra-cmake-modules
        epoxy
        xorg.libXdmcp
        libsForQt5.kconfig
        libsForQt5.kconfigwidgets
        libsForQt5.kcrash
        libsForQt5.kglobalaccel
        libsForQt5.kio
        libsForQt5.kinit
        libsForQt5.kwin
        libsForQt5.knotifications
        libsForQt5.qt5.qtbase
        libsForQt5.qt5.qttools
        libsForQt5.qt5.qtx11extras
      ];
      preConfigure = ''
        local modulepath=$(kf5-config --install module)
        local datapath=$(kf5-config --install data)
        substituteInPlace kwin-effects/CMakeLists.txt \
        --replace "\''${MODULEPATH}" "$out/''${modulepath#/nix/store/*/}" \
        --replace "\''${DATAPATH}"   "$out/''${datapath#/nix/store/*/}"
      '';
    })
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

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.tim = { pkgs, ... }: {
    home.packages = with pkgs; [
      spotify
      google-chrome
      plasma-pa
      dmenu
      fd
      ripgrep
      hack-font
      hsetroot
      dunst
      udiskie
      playerctl
      alsaUtils
      sxiv
      highlight
      nixfmt
    ];
    programs = {
      vscode = import ./vscode.nix pkgs;
      alacritty = import ./alacritty.nix;
      zathura.enable = true;
      fish = {
        enable = true;
        shellAbbrs = {
          nrs = "doas nixos-rebuild switch";
          k = "kill (ps aux | fzf | awk '{print $2}')";
          gpm = "git push -u origin main";
          nn = "cd ~/dev/nixos && nvim configuration.nix";
          r = "ranger";
        };
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      fzf = { enable = true; };
      htop = { enable = true; };
      neovim = {
        enable = true;
        package = pkgs.neovim-nightly;
        viAlias = true;
        vimAlias = true;
        plugins = with pkgs.vimPlugins; [
          nvim-treesitter
          vim-commentary
          vim-surround
          # Custom-built packages
          vimPlugsFromSource.nvim-autopairs
          vimPlugsFromSource.rainbow-parentheses
        ];
        extraConfig = ''
          ${builtins.readFile ./nvim/init.vim}
        '';
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

