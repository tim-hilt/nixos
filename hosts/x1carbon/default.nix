{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix  ];
  
  # Profile-additions
  home-manager.users.tim = {
    programs = {
      autorandr = import ./autorandr.nix;
      git.userEmail = "timhilt@live.de";
    };
  };
}
