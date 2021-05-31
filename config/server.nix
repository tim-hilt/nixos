{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.extraUsers.tim = {
    isNormalUser = true;
    description = "Tim Hilt";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
