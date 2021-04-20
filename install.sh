#! /usr/bin/env sh

# Add needed channels
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs

# Move files into place
cp /etc/nixos/hardware-configuration.nix .
chown hardware-configuration.nix $USER
rm -rf /etc/nixos
ln -s $(pwd) /etc/nixos

# Install all the files
nixos-rebuild switch --upgrade

# Delete unnecessary files
nix-collect-garbage -d

# Reboot
echo "Machine will reboot in 5 seconds"
reboot
