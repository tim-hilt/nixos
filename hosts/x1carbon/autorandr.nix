{
  home-manager.users.tim.programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      "change-background" = "hsetroot -cover ~/Pictures/background.jpg";
    };
    profiles = {
      "mobile" = {
        fingerprint = {
          eDP-1 =
            "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
        };
        config = {
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2.enable = false;
          eDP-1 = {
            enable = true;
            crtc = 0;
            mode = "1920x1080";
            position = "0x0";
            primary = true;
            rate = "60.01";
          };
        };
      };
      "dp1" = {
        fingerprint = {
          eDP-1 =
            "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
          DP-1 =
            "00ffffffffffff0030aee961000000000c1e0104a53c22783e6665a9544c9d26105054a1080081c0810081809500a9c0b300d1c00101565e00a0a0a0295030203500615d2100001a000000fc00503237682d32300a2020202020000000fd00324c1e5a24000a202020202020000000ff00563930354d3858500affffffff01d2020318f14b9005040302011f13140e0f23090f0783010000662156aa51001e30468f33000f282100001eab22a0a050841a30302036000f282100001c7c2e90a0601a1e40302036000f282100001c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
        };
        config = {
          HDMI-1.enable = false;
          DP-2.enable = false;
          DP-1 = {
            crtc = 0;
            mode = "2560x1440";
            position = "0x0";
            primary = true;
            rate = "59.95";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            position = "2560x360";
            rate = "60.01";
          };
        };
      };
      "dp2" = {
        fingerprint = {
          eDP-1 =
            "00ffffffffffff0009e5df0600000000011a0104a51f1178028631a3544e9b250e5054000000010101010101010101010101010101013c3780de703814403c20360035ad1000001a302c80de703814403020360035ad1000001a000000fe00424f452043510a202020202020000000fe00485631343046484d2d4e36310a0049";
          DP-2 =
            "00ffffffffffff0030aee961000000000c1e0104a53c22783e6665a9544c9d26105054a1080081c0810081809500a9c0b300d1c00101565e00a0a0a0295030203500615d2100001a000000fc00503237682d32300a2020202020000000fd00324c1e5a24000a202020202020000000ff00563930354d3858500affffffff01d2020318f14b9005040302011f13140e0f23090f0783010000662156aa51001e30468f33000f282100001eab22a0a050841a30302036000f282100001c7c2e90a0601a1e40302036000f282100001c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
        };
        config = {
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2 = {
            enable = true;
            crtc = 0;
            mode = "2560x1440";
            position = "0x0";
            primary = true;
            rate = "59.95";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            position = "2560x360";
            rate = "60.01";
          };
        };
      };
    };
  };
}
