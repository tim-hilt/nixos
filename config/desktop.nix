{ pkgs, ... }: {
  # Needed for Keychron K2
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple" ];

  hardware.bluetooth.enable = true;
  # Comment this in the first time you want to connect to AirPods.
  # In order to connect, you have to press the button on the back
  # of the AirPods case.
  # `breder` is only needed for the initial connection of the AirPods.
  # Afterwards the mode can be relaxed to `dual` (the default) again.
  # hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # dwm related
  services.xserver.windowManager.dwm.enable = true;
  services.autorandr.enable = true;
  services.logind.lidSwitchDocked = "suspend";

  programs.light.enable = true; # Daemon to configure backlight on laptop

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "nodeadkeys";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.printing.drivers = with pkgs; [
  #   cups-kyodialog3
  # ];

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

  users.extraUsers.tim.extraGroups = [ "video" ];
}
