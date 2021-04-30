{
  imports = [ ./hardware-configuration.nix ../common ];

  networking.hostName = "x1carbon";

  # Profile-additions
  home-manager.users.tim = {
    programs = {
      autorandr = import ./autorandr.nix;
      git.userEmail = "timhilt@live.de";
    };
  };
}
