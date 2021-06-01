{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  home-manager.users.tim.programs.git.userEmail = "thilt@in-technology.eu";
}
