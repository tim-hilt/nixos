{ unstable, utils, home-manager, ... }:
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
      home-manager.sharedModules = [{
        home.packages = with unstable.legacyPackages.x86_64-linux; [
          tmux
          ranger
          gdu
        ];
      }];
    }
  ];

  desktopModules = with sharedModules;
    nonGraphicalModules
    ++ [ desktop { home-manager.users.tim = ./home-manager/desktop; } ];

  workModules = with sharedModules;
    desktopModules ++ [{ home-manager.users.tim = ./home-manager/work; }];
in { inherit sharedModules nonGraphicalModules desktopModules workModules; }
