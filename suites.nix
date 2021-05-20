{ utils, home-manager }:
let
  sharedModules =
    utils.lib.modulesFromList [ ./config/server.nix ./config/desktop.nix ];

  # serverModules is just a specd down config of desktop
  nonGraphicalModules = with sharedModules; [
    server
    utils.nixosModules.saneFlakeDefaults
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.tim = ./home-manager/server;
    }
  ];

  desktopModules = with sharedModules;
    nonGraphicalModules
    ++ [ desktop { home-manager.users.tim = ./home-manager/desktop; } ];
in { inherit sharedModules nonGraphicalModules desktopModules; }
