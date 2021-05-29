{
  description = "My NixOS configuration";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs =
    inputs@{ self, unstable, utils, home-manager, neovim, nixos-hardware, ... }:
    let
      suites = import ./suites.nix {
        inherit utils;
        inherit home-manager;
      };
    in utils.lib.systemFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channels.unstable.input = unstable;
      channels.unstable.config.allowUnfree = true;

      sharedOverlays = [
        (final: prev: {
          neovim-nightly = neovim.defaultPackage.${prev.system};
          hello-kde = unstable.legacyPackages.x86_64-linux.callPackage
            ./overlays/hello-kde.nix { };
          dwm = prev.dwm.overrideAttrs (_: {
            src = unstable.legacyPackages.x86_64-linux.fetchFromGitHub {
              owner = "tim-hilt";
              repo = "dwm-src";
              rev = "main";
              sha256 = "0yb9n715i569mm257c2mf0k1f4y0ayqx7mms7dvp58kz09p64303";
            };
          });
        })
      ];

      hostDefaults = {
        system = "x86_64-linux";
        channelName = "unstable";
      };

      hosts.x1carbon.modules = suites.desktopModules ++ [ ./hosts/x1carbon ];

      hosts.x220.modules = suites.desktopModules
        ++ [ ./hosts/x220 nixos-hardware.nixosModules.lenovo-thinkpad-x220 ];
    };
}
