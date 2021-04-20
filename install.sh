#! /usr/bin/env sh

# 1. Add all channels
# 2. Delete /etc/nixos/configuration.nix
# 3. Symlink ./configuration.nix to /etc/nixos/configuration.nix (does this work in a multi-file-context?)
# 4. Run nixos-rebuild switch with all the files in place
# 5. Delete old generations
# 6. Reboot
