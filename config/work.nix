{ pkgs, ... }: {
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
}
