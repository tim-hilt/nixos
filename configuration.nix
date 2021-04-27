# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  vimPlugsFromSource = (import ./nvim/nvim-plugins.nix) pkgs;
in
{
  imports =
    [
      ./hardware-configuration.nix 
      <home-manager/nixos>
    ];

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

  environment.variables = { EDITOR = "nvim"; VISUAL = "nvim"; };

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (pkgs.libsForQt5.callPackage({mkDerivation}: mkDerivation) {} rec {
      name = "hello";
      version = "Hidden Hedgehog";
      src = pkgs.fetchFromGitHub {
        owner = "n4n0GH";
        repo = "hello";
        rev = "master";
        sha256 = "sha256:1898swsq07rwnd3gdff7v153hzyv9k1hf5817z7a7gr8rphbn3km";
      };
      nativeBuildInputs = with pkgs; [
        cmake
      ];
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
        substituteInPlace kwin-effects/CMakeLists.txt \
        --replace "\''${MODULEPATH}" "$out/qt-5.15.2/plugins" \
        --replace "\''${DATAPATH}"   "$out/share"
      '';
    })
    ranger
    tmux
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs = {
    light.enable = true;
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
    (self: super: {
      dwm = super.dwm.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "tim-hilt";
          repo = "dwm-src";
          rev = "main";
          sha256 = "sha256:0yb9n715i569mm257c2mf0k1f4y0ayqx7mms7dvp58kz09p64303";
        };
      });
    })
  ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users= { 
    tim = {
      isNormalUser = true;
      description = "Tim Hilt";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "video" ];
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
      ripgrep
      hack-font
      hsetroot
      dunst
      udiskie
      playerctl
      alsaUtils
      sxiv
      highlight
    ];
    programs = {
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
      fzf = {
        enable = true;
      };
      autorandr = {
        enable = true;
        hooks.postswitch = {
          "change-background" = "hsetroot -cover ~/Pictures/background.jpg";
        };
        profiles = {
          "mobile" = {
            fingerprint = {
              eDP-1 = "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
            };
            config = {
              DP-1.enable = false;
              HDMI-1.enable = false;
              DP-2.enable = false;
              eDP-1 = {
                enable = true;
                crtc = 0;
                mode = "1920x1080";
                position = "0x0";
                primary = true;
                rate = "60.01";
              };
            };
          };
          "dp1" = {
            fingerprint = {
              eDP-1 = "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
              DP-1 = "00ffffffffffff0030aee961000000000c1e0104a53c22783e6665a9544c9d26105054a1080081c0810081809500a9c0b300d1c00101565e00a0a0a0295030203500615d2100001a000000fc00503237682d32300a2020202020000000fd00324c1e5a24000a202020202020000000ff00563930354d3858500affffffff01d2020318f14b9005040302011f13140e0f23090f0783010000662156aa51001e30468f33000f282100001eab22a0a050841a30302036000f282100001c7c2e90a0601a1e40302036000f282100001c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
            };
            config = {
              HDMI-1.enable = false;
              DP-2.enable = false;
              DP-1 = {
                crtc = 0;
                mode = "2560x1440";
                position = "0x0";
                primary = true;
                rate = "59.95";
              };
              eDP-1 = {
                enable = true;
                crtc = 1;
                mode = "1920x1080";
                position = "2560x360";
                rate = "60.01";
              };
            };
          };
          "dp2" = {
            fingerprint = {
              eDP-1 = "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
              DP-2 = "00ffffffffffff0030aee961000000000c1e0104a53c22783e6665a9544c9d26105054a1080081c0810081809500a9c0b300d1c00101565e00a0a0a0295030203500615d2100001a000000fc00503237682d32300a2020202020000000fd00324c1e5a24000a202020202020000000ff00563930354d3858500affffffff01d2020318f14b9005040302011f13140e0f23090f0783010000662156aa51001e30468f33000f282100001eab22a0a050841a30302036000f282100001c7c2e90a0601a1e40302036000f282100001c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
            };
            config = {
              DP-1.enable = false;
              HDMI-1.enable = false;
              DP-2 = {
                enable = true;
                crtc = 0;
                mode = "2560x1440";
                position = "0x0";
                primary = true;
                rate = "59.95";
              };
              eDP-1 = {
                enable = true;
                crtc = 1;
                mode = "1920x1080";
                position = "2560x360";
                rate = "60.01";
              };
            };
          };
        };
      };
      htop = {
        enable = true;
      };
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
      git = {
        enable = true;
        userName = "Tim Hilt";
        userEmail = "timhilt@live.de";  # TODO: This is something, that would have to be modularized!
      };
      alacritty = {
        enable = true;
        settings = {
          env = {
            TERM = "xterm-256color";
            WINIT_X11_SCALE_FACTOR = "1";
          };
          window = {
            padding = {
              x = 40;
              y = 30;
            };
          };
          font = {
            normal.family = "Hack";
            size = 11.0;
          };
          colors = {
            primary = {
              background = "0x282c34";
              foreground = "0xbbc2cf";
            };
            normal = {
              black = "0x282c34";
              red = "0xff6c6b";
              green = "0x98be65";
              yellow = "0xecbe7b";
              blue = "0x51afef";
              magenta = "0xc678dd";
              cyan = "0x46d9ff";
              white = "0xbbc2cf";
            };
          };
          key_bindings = [
            {
              key = "Return";
              mods = "Shift";
              chars = "\\x1b[13;2u";
            }
          ];
        };
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

