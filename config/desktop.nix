{ pkgs, ... }: {
  # Needed for Keychron K2
  boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple"  ];

  hardware.bluetooth.enable = true;

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
  # services.printing.drivers = with pkgs; [
  #   cups-kyodialog3
  # ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable sound. (But don't use pulse)
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

  programs.light.enable = true;

  users.extraUsers.tim.extraGroups = [ "video" ];
}
