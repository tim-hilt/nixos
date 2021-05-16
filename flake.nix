{
  description = "My NixOS configuration";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs@{ self, unstable, utils, home-manager, neovim, ... }:
    let suites = import ./suites.nix { inherit utils; inherit home-manager; };
    in utils.lib.systemFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channels.unstable.input = unstable;
      channels.unstable.config.allowUnfree = true;

      sharedOverlays = [
        (final: prev: {
          neovim-nightly = neovim.defaultPackage.${prev.system};
        })
      ];

      hostDefaults = {
        system = "x86_64-linux";
        channelName = "unstable";
      };

      hosts.x1carbon.modules = suites.desktopModules ++ [ ./hosts/x1carbon ];
    };
}
