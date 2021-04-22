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
  
  - [ ] Configure alacritty via home-manager
  - [ ] Make setup modular
    - [Inspiration](https://github.com/rummik/nixos-config)
  - [ ] Find out, how to configure Displayport-Audio
  - [ ] ~~Docker~~ Podman for container-management (Kubernetes? kubectl / kind / helm...)
  - [ ] *btrfs-partition* (On hold)
  - [x] doas instead of sudo
  - [x] pipewire instead of pulseaudio
  - [x] packages from unstable channel
  - [x] dotfiles-management with home-manager
  - [x] correct keyboard-model and locales
  - [x] configuration.nix with symlink (superseeded by setup-script)
  - [x] Configure Bluetooth
  - [x] Don't commit `hardware.nix`!
  - [x] Write setup-script
  
  ## Window Managers
  
  ### KDE
  
  - [ ] hello window decorations
  - [x] Windows-tiling script
  - [x] no titlebar, when maximized
  
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

  - [ ] (Migrate init.vim to home-manager)
  - [x] Find correct way to configure neovim (maybe it's better to install system-wide and just manage .config/nvim via home-manager?)
    - Build custom packages and include them in the config
</details>
