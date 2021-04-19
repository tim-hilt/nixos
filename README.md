# Install

To install, clone the repository, delete your `/etc/nixos`-directory and create a soft-link from the cloned repository to `/etc/`.

``` bash
$ git clone https://github.com/tim-hilt/nixos
$ doas ln -s nixos/ /etc/
```

# Todo

<details>
  <summary>Click to expand!</summary>

  ## Options
  
  - [x] doas instead of sudo
  - [x] pipewire instead of pulseaudio
  - [x] packages from unstable channel
  - [ ] dotfiles-management with home-manager
  - [x] correct keyboard-model and locales
  - [x] configuration.nix with symlink
  - [ ] btrfs-partition
  - [x] Configure Bluetooth
  - [ ] Make setup modular, so that multiple machines can use the same preconfigured options (`common.nix` + conditional import, based on hostname or something like that)
  - [ ] Don't commit `hardware.nix`!
  
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
</details>
