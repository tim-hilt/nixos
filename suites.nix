{ utils, home-manager }:
let
  sharedModules = utils.lib.modulesFromList [ ./config ];
  desktopModules = with sharedModules; [
    config
    utils.nixosModules.saneFlakeDefaults
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.tim = ./home-manager;
    }
  ];
in { inherit sharedModules desktopModules; }
