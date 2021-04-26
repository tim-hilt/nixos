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
  
  - [ ] Configure dunst via home-manager
  - [ ] Install and configure gammastep (successor to redshift)
  - [ ] Use flakes
  - [ ] Make setup modular
    - [Inspiration](https://github.com/rummik/nixos-config)
  - [ ] Find out, how to configure Displayport-Audio
  - [ ] ~~Docker~~ Podman for container-management (Kubernetes? kubectl / kind / helm...)
  - [ ] *btrfs-partition* (On hold)
  - [x] Try out autorandr
  - [x] Try out bluetooth on dwm
  - [x] Configure alacritty via home-manager
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
  
  - [ ] hello window decorations *(In Progress)*
  - [x] Windows-tiling script
  - [x] no titlebar, when maximized
  
  ### dwm
  
  - [x] Find better way of installing and managing the package
    - Auto push to `dwm-src`-repository; include this repository in the dwm overlay
  - [x] Include battery-percentage in status-bar
  - [x] Build own nix-package
  
  ## Packages
  
  - [ ] openvpn *(work-configuration)*
  - [ ] intellij-idea *(work-configuration)*
  - [x] spotify
  - [x] vs-code
  - [x] nvim-nightly
  - [x] go
  - [x] rust

  ### Neovim

  - [x] Migrate init.vim to home-manager
    - I actually tagged that as "in-progress" before, but since I basically learned everything I need to know to include new stuff, I'll mark that as done.
  - [x] Find correct way to configure neovim (maybe it's better to install system-wide and just manage .config/nvim via home-manager?)
    - Build custom packages and include them in the config
</details>
