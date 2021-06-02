{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  users.extraUsers.tim.extraGroups = [ "docker" ];
}
