# Install

To install:

**Don't**. these are my personal dotfiles, that will most likely not make sense for your use-case.

If you're me:

1. Partition and format your disks
2. `nixos-generate-config`
3. Clone this repository to a sensible location
4. Run `sh install.sh`

# Todo

<details>
  <summary>Click to expand!</summary>

  ## Options
  
  - [x] doas instead of sudo
  - [x] pipewire instead of pulseaudio
  - [x] packages from unstable channel
  - [x] dotfiles-management with home-manager
  - [x] correct keyboard-model and locales
  - [x] configuration.nix with symlink (superseeded by setup-script)
  - [ ] (btrfs-partition)
  - [x] Configure Bluetooth
  - [ ] ~~Docker~~ Podman for container-management
  - [ ] Make setup modular, so that multiple machines can use the same preconfigured options (`common.nix` + conditional import, based on hostname or something like that)
  - [ ] Don't commit `hardware.nix`!
  - [ ] Write setup-script
  
  ## Window Managers
  
  ### KDE
  
  - [x] Windows-tiling script
  - [x] no titlebar, when maximized
  - [ ] hello window decorations
  
  ### dwm
  
  - [ ] Build own nix-package
  
  ## Packages
  
  - [x] spotify
  - [x] vs-code
  - [ ] openvpn
  - [ ] intellij-idea
  - [x] nvim-nightly
  - [x] go
  - [x] rust

  ### Neovim

  - [ ] Migrate init.vim to home-manager
</details>
