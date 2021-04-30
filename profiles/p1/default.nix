{ pkgs, ... }: # TODO: Figure out, if this is the correct syntax
{
  imports = [ ./hardware-configuration.nix ../common ];

  networking.hostName = "p1";

  # Profile-additions
  home-manager.users.tim = {
    home.packages = with pkgs; [
      teams
      keepass
      openvpn
      jetbrains.idea-ultimate
      # TODO: Figure out Docker-/Kubernetes-setup
    ];
    programs = {
      autorandr = import ./autorandr.nix;
      git.userEmail = "thilt@in-technology.eu";
    };
  };
}
