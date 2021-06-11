{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  
  systemd.enableUnifiedCgroupHierarchy = false;

  users.extraUsers.tim.extraGroups = [ "docker" ];
}
