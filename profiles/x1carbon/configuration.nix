{
  imports = [ ./hardware-configuration.nix ../common/configuration.nix ];

  # Profile-additions
  home-manager.users.tim = {
    programs = {
      autorandr = import ./autorandr.nix;
      git = {
        enable = true;
        userName = "Tim Hilt";
        userEmail = "timhilt@live.de";
      };
    };
  };
}
