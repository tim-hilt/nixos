{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./autorandr.nix ];

  # Profile-additions
  home-manager.users.tim.programs.git.userEmail = "timhilt@live.de";
}
